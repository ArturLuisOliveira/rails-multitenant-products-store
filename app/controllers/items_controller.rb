# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :doorkeeper_authorize!, only: %i[update destroy create]
  before_action :load_items, only: %i[index]
  before_action :load_item, only: %i[show update destroy]
  before_action :load_category, only: %i[create]

  def index
    render json: @items, status: :ok, each_serializer: ItemSerializer
  end

  def show
    render json: @item, status: :ok, serializer: ItemSerializer
  end

  def update
    return render json: {}, status: :unauthorized unless item_belongs_to_user_store?

    updater = Items::Updater.new(item: @item, params: update_params)

    if updater.update
      render json: @item, status: :ok, serializer: ItemSerializer
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  def destroy
    return render json: {}, status: :unauthorized unless item_belongs_to_user_store?

    destroyer = Items::Destroyer.new(@item)

    if destroyer.destroy
      render json: @item, status: :ok
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  def create
    unless category_belongs_to_user_store?
      return render json: {},
                    status: :bad_request
    end

    creator = Items::Creator.new(
      store: current_user.store,
      description: create_params[:description],
      name: create_params[:name],
      category: @category
    )

    @item = creator.create

    if @item
      render json: @item, status: :created, serializer: ItemSerializer
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  private

  def index_params
    params.permit(:store_id, :category_id)
  end

  def update_params
    params.permit(:id, :name, :description)
  end

  def create_params
    params.permit(:name, :description, :category_id)
  end

  def load_items
    @items = Items::Query.new
                         .by_store(index_params[:store_id])
                         .by_category(index_params[:category_id])
                         .query
  end

  def load_item
    @item = Items::Finder.new(params[:id]).find
  end

  def load_category
    @category = Categories::Finder.new(create_params[:category_id]).find
  end

  def category_belongs_to_user_store?
    @category.store == current_user.store
  end

  def item_belongs_to_user_store?
    @item.store == current_user.store
  end
end

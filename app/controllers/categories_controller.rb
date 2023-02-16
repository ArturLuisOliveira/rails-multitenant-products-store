# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :doorkeeper_authorize!, only: %i[create update destroy]
  before_action :load_store, only: %i[index]
  before_action :load_category, only: %i[update destroy]

  def index
    render json: categories, status: :ok, each_serializer: CategorySerializer
  end

  def create
    creator = Categories::Creator.new(
      store: current_user.store,
      name: create_params[:name],
      description: create_params[:description]
    )

    if creator.create
      render json: {}, status: :created
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  def update
    unless category_belongs_to_user_store?
      render json: { error: 'Unauthorized access' },
             status: :unauthorized and return
    end

    updater = Categories::Updater.new(
      category: @category,
      params: update_params
    )

    if updater.update
      render json: @category, status: :ok, serializer: CategorySerializer
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  def destroy
    unless category_belongs_to_user_store?
      render json: { error: 'Unauthorized access' },
             status: :unauthorized and return
    end

    destroyer = Categories::Destroyer.new(@category.id)

    if destroyer.destroy
      render json: @category, status: :ok, serializer: CategorySerializer
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  private

  def index_params
    params.permit(:store_id)
  end

  def load_store
    @store = Stores::Finder.new(params[:store_id]).find
  end

  def categories
    @categories = Categories::Query.new.by_store(@store).query
  end

  def create_params
    params.permit(:name, :description)
  end

  def update_params
    params.permit(:id, :name, :description)
  end

  def load_category
    @category = Categories::Finder.new(params[:id]).find
  end

  def category_belongs_to_user_store?
    current_user.store == @category.store
  end
end

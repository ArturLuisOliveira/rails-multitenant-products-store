# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :doorkeeper_authorize!, only: %i[update destroy create]
  before_action :items, only: %i[index]
  before_action :item, only: %i[show update destroy]

  def index
    render json: @items, status: :ok, each_serializer: ItemSerializer
  end

  def show
    render json: @item, status: :ok, serializer: ItemSerializer
  end

  def update
    return render json: {}, status: :unauthorized unless current_user.store == @item.store

    if Items::Updater.new(item:, params: update_params).update
      render json: @item, status: :ok, serializer: ItemSerializer
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  def destroy
    return render json: {}, status: :unauthorized unless current_user.store == @item.store

    if Items::Destroyer.new(@item).destroy
      render json: @item, status: :ok
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  def create
    render status: :created
  end

  private

  def index_params
    params.permit(:store_id, :category_id)
  end

  def items
    @items = Items::Query.new
                         .by_store(index_params[:store_id])
                         .by_category(index_params[:category_id])
                         .query
  end

  def item
    @item = Items::Finder.new(params[:id]).find
  end

  def update_params
    params.permit(:id, :name, :description)
  end
end

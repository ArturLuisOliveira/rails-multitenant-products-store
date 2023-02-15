# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :doorkeeper_authorize!, only: %i[update destroy create]
  before_action :items, only: %i[index]

  def index
    render json: @items, status: :ok, each_serializer: ItemSerializer
  end

  def show
    render json: {}, status: :ok
  end

  def update
    render status: :ok
  end

  def destroy
    render status: :ok
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
end

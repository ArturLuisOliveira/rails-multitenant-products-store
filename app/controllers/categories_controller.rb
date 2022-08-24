# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :doorkeeper_authorize!, only: %i[create update destroy]
  before_action :load_store, only: %i[index]
  before_action :load_category, only: %i[update]

  def index
    render json: categories, status: :ok, each_serializer: CategorySerializer
  end

  def create
    if Categories::Creator.new(
      store: current_user.store,
      name: create_params[:name],
      description: create_params[:description]
    ).create
      render json: {}, status: :created
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  def update
    unless current_user.store == @category.store
      render json: { error: 'Unauthorized access' },
             status: :unauthorized and return
    end

    if Categories::Updater.new(
      category: @category,
      params: update_params
    ).update
      render json: @category, status: :ok, serializer: CategorySerializer
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  def destroy
    render status: :ok
  end

  private

  # index
  def index_params
    params.permit(:store_id)
  end

  def load_store
    @store = Stores::Finder.new(params[:store_id]).find
  end

  def categories
    @categories = Categories::Query.new.by_store(@store).query
  end

  # create
  def create_params
    params.permit(:name, :description)
  end

  # update

  def update_params
    params.permit(:id, :name, :description)
  end

  def load_category
    @category = Categories::Finder.new(params[:id]).find
  end
end

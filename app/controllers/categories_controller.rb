# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :doorkeeper_authorize!, only: %i[create update destroy]
  before_action :load_store, only: %i[index]

  def index
    render json: categories, status: :ok, each_serializer: CategorySerializer
  end

  def create
    render status: :created
  end

  def update
    render status: :ok
  end

  def destroy
    render status: :ok
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
end

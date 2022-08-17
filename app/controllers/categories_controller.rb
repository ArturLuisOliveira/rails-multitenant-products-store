# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :doorkeeper_authorize!, only: %i[create update destroy]

  def index
    render json: {}, status: :ok
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
end

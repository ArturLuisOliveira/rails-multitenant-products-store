# frozen_string_literal: true

class CategoriesController < ApplicationController
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

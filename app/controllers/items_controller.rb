# frozen_string_literal: true

class ItemsController < ApplicationController
  def index
    render json: {}, status: :ok
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
end

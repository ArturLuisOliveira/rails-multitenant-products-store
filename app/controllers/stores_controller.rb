# frozen_string_literal: true

class StoresController < ApplicationController
  before_action :load_store, only: [:show]
  def show
    render json: @store, status: :ok, serializer: StoreSerializer
  end

  def update
    render status: :ok
  end

  private

  def load_store
    @store = Stores::Finder.new(params[:id]).find
  end
end

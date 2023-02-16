# frozen_string_literal: true

class StoresController < ApplicationController
  before_action :doorkeeper_authorize!, only: [:update]
  before_action :load_store

  def show
    render json: @store, status: :ok, serializer: StoreSerializer
  end

  def update
    unless user_belongs_to_store?
      render json: {},
             status: :unauthorized and return
    end

    updater = Stores::Updater.new(@store, update_params)

    if updater.update
      head :ok
    else
      render_something_went_wrong
    end
  end

  private

  def load_store
    @store = Stores::Finder.new(params[:id]).find
  end

  def show_params
    params.permit(:id)
  end

  def update_params
    params.permit(:description)
  end

  def user_belongs_to_store?
    current_user.store == @store
  end
end

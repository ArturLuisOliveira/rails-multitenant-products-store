# frozen_string_literal: true

class ImagesController < ApplicationController
  before_action :authenticate_user!

  def create
    render status: :created
  end

  def destroy
    render status: :ok
  end
end

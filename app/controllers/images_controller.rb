# frozen_string_literal: true

class ImagesController < ApplicationController
  def create
    render status: :created
  end

  def destroy
    render status: :ok
  end
end

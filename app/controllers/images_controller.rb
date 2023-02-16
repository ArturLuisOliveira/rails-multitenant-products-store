# frozen_string_literal: true

# TODO
class ImagesController < ApplicationController
  before_action :doorkeeper_authorize!

  def create
    render status: :created
  end

  def destroy
    render status: :ok
  end
end

# frozen_string_literal: true

class StoresController < ApplicationController
  def show
    render json: {}, status: :ok
  end
end

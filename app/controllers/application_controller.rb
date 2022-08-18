# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def current_user
    return unless doorkeeper_token && doorkeeper_token[:resource_owner_id].present?

    @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
  end
end

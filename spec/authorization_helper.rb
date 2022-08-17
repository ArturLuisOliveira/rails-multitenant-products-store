# frozen_string_literal: true

require 'rails_helper'

module AuthorizationHelper
  def create_headers_with_bearer_token(user)
    application = create(:application)
    token = create(:access_token, application:, resource_owner_id: user.id)

    { Authorization: "Bearer #{token.token}" }
  end
end

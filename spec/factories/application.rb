# frozen_string_literal: true

FactoryBot.define do
  factory :application, class: 'Doorkeeper::Application' do
    name { 'web app' }
    uid { '123456' }
    secret { '123456' }
    redirect_uri { '' }
  end
end

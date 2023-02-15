# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { Faker::Company.name }
    description { Faker::Lorem.sentence(word_count: 30) }
    store { create(:store) }
    category { create(:category) }
  end
end

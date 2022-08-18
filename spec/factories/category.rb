# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { Faker::Company.name }
    description { Faker::Lorem.sentence(word_count: 30) }
    store
  end
end

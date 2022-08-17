# frozen_string_literal: true

class Store < ApplicationRecord
  has_many :users, dependent: :destroy
end

# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :store
  belongs_to :category
end

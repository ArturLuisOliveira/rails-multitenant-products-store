# frozen_string_literal: true

class AddStoreToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :store, foreign_key: true, null: true
  end
end

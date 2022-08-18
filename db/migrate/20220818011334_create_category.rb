# frozen_string_literal: true

class CreateCategory < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :description
      t.timestamps

      t.references :store, null: false, foreign_key: true
    end
  end
end

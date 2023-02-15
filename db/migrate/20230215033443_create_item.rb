class CreateItem < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.jsonb :aditional_info, default: []
      t.timestamps

      t.references :category, null: true, foreign_key: true
      t.references :store, null: false, foreign_key: true
    end
  end
end

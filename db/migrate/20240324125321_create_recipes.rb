# frozen_string_literal: true

class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :title, null: false
      t.string :image
      t.decimal :rating, null: false, default: 0
      t.string :raw_ingredients, null: false, default: ''

      t.integer :cook_time
      t.integer :prep_time
      t.string :cuisine
      t.string :category
      t.string :author

      t.index :rating

      t.timestamps
    end
  end
end

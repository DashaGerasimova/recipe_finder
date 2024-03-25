# frozen_string_literal: true

class CreateRecipeIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_ingredients do |t|
      t.string :title, null: false

      t.belongs_to :recipe, index: true, null: false
      t.belongs_to :ingredient, index: true, null: false

      t.timestamps
    end
  end
end

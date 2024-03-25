# frozen_string_literal: true

class AddSearchIndex < ActiveRecord::Migration[7.1]
  def change
    add_index :ingredients, "to_tsvector('english'::regconfig, COALESCE((title)::text, ''::text))",
              name: :ingredients_search_idx, using: :gin
    add_index :recipes, "to_tsvector('english'::regconfig, COALESCE((raw_ingredients)::text, ''::text))",
              name: :recipe_search_idx, using: :gin
  end
end

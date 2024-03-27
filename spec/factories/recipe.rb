# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    title { 'Recipe' }
    image { 'https://example.com/image.jpg' }
    rating { '4.5' }
    cook_time { 30 }
    prep_time { 15 }
    cuisine { 'Italian' }
    category { 'Pasta' }
    author { 'John Doe' }
    recipe_ingredients { build_list(:recipe_ingredient, 3) }
  end
end

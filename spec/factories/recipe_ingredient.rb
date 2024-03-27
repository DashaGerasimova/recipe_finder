# frozen_string_literal: true

FactoryBot.define do
  factory :recipe_ingredient do
    title { 'Recipe Ingredient' }
    ingredient { build(:ingredient) }
  end
end

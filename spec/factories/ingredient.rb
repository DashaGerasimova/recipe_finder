# frozen_string_literal: true

FactoryBot.define do
  factory :ingredient do
    sequence(:title) { |n| "Ingredient #{n}" }
  end
end

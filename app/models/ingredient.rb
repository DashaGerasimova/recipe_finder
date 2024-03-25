# frozen_string_literal: true

class Ingredient < ApplicationRecord
  include PgSearch::Model

  validates :title, presence: true

  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients

  pg_search_scope :search, against: :title,
                           using: {
                             tsearch: { dictionary: 'english', prefix: true }
                           }
end

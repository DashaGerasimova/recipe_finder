# frozen_string_literal: true

class Recipe < ApplicationRecord
  include PgSearch::Model

  validates :title, :rating, presence: true

  validates :rating, numericality: {
    greater_than_or_equal_to: 0, less_than_or_equal_to: 5
  }

  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  pg_search_scope :search_ranked, against: :raw_ingredients,
                                  using: {
                                    tsearch: { dictionary: 'english' }
                                  }
end

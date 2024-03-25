# frozen_string_literal: true

module Api
  class RecipesController < ApplicationController
    def index
      @recipes = Recipe
                 .includes(:recipe_ingredients)
                 .search_ranked(ingredients)
                 .page(params[:page])
    end

    private

    def ingredients
      params[:ingredients]&.join(' ')
    end
  end
end

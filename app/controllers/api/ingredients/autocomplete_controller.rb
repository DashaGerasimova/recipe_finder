# frozen_string_literal: true

module Api
  module Ingredients
    class AutocompleteController < ApplicationController
      AUTOCOMPLETE_LIMIT = 10

      def index
        results = Ingredient.search(params[:q])
                            .limit(AUTOCOMPLETE_LIMIT)
                            .reorder('length(title)')
                            .pluck(:title)

        render json: { data: results }
      end
    end
  end
end

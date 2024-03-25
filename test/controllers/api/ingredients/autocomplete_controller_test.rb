# frozen_string_literal: true

require 'test_helper'

module Api
  module Ingredients
    class AutocompleteControllerTest < ActionDispatch::IntegrationTest
      test 'should get index' do
        get api_ingredients_autocomplete_index_url
        assert_response :success
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::RecipesController, type: :controller do
  describe 'GET #index' do
    let!(:recipe) { create(:recipe) }

    let(:banana_recipe) do
      create(:recipe, title: 'banana recipe', raw_ingredients: 'water banana milk')
    end

    let(:apple_recipe) do
      create(:recipe, title: 'apple recipe', raw_ingredients: 'apple wheat')
    end

    let(:banana_apple_recipe) do
      create(:recipe, title: 'apple banana recipe', raw_ingredients: 'apple banana strawberry')
    end

    let!(:recipes) do
      [
        banana_recipe,
        apple_recipe,
        banana_apple_recipe
      ]
    end

    context 'when requesting both ingredients' do
      let(:ingredients) { %w[apple banana] }

      it 'returns a successful response' do
        get :index, params: { ingredients: }, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['data'].map { |recipe| recipe['id'] }).to eq([banana_apple_recipe.id])
      end
    end

    context 'when requesting one ingredient' do
      let(:ingredients) { ['apple'] }

      it 'returns a successful response' do
        get :index, params: { ingredients: }, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['data'].map { |recipe| recipe['id'] })
          .to match_array([banana_apple_recipe.id, apple_recipe.id])
      end
    end
  end
end

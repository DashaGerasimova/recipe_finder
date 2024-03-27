# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Ingredients::AutocompleteController, type: :controller do
  describe 'GET #index' do
    let!(:ingredients) do
      [
        create(:ingredient, title: 'Apple'),
        create(:ingredient, title: 'Apricot')
      ]
    end

    context 'there is match' do
      let(:query) { 'apple' }

      it 'returns a successful response' do
        get :index, params: { q: query }
        expect(response).to have_http_status(:success)

        expect(JSON.parse(response.body)['data']).to eq(['Apple'])
      end
    end

    context 'there is no match' do
      let(:query) { 'hello' }

      it 'returns an empty list' do
        get :index, params: { q: query }
        expect(response).to have_http_status(:success)

        expect(JSON.parse(response.body)['data']).to eq([])
      end
    end
  end
end

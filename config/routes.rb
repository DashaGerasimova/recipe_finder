# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :ingredients do
      get :autocomplete, to: 'autocomplete#index'
    end

    resources :recipes, only: :index
  end
end

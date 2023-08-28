# frozen_string_literal: true

Rails.application.routes.draw do
  get 'api/pokemons/:name', to: 'api/pokemons#index'
end

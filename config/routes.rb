Rails.application.routes.draw do
  get 'pokemons/:name', to: 'pokemons#index'
end

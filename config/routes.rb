# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }

  namespace :api do
    namespace :v1 do
      resources :posts, only: %i[create update destroy]
      resources :comments, only: %i[create update destroy]
    end
  end
end

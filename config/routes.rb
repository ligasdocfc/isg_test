# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }

  namespace :api do
    namespace :v1 do
      resources :posts
    end
  end
end

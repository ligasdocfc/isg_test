# frozen_string_literal: true

module Api
  class PokemonsController < ApplicationController
    def index
      pokemon_abilities = FetchPokemonAbilitiesInteractor.call(name: params[:name])

      if pokemon_abilities.success?
        render json: { abilities: pokemon_abilities[:message] }.to_json, status: :ok
      else
        render json: errors_serializer(pokemon_abilities[:message]),
               status: :unprocessable_entity
      end
    end

    private

    def params_permit
      params.permit(:name)
    end
  end
end

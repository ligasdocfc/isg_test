# frozen_string_literal: true

module Api
  class PokemonsController < ApplicationController
    def index
      pokemon_skills = FetchPokemonSkillsInteractor.call(name: params[:name].downcase)

      if pokemon_skills.success?
        render json: { skills: pokemon_skills[:message] }.to_json, status: :ok
      else
        render json: errors_serializer(pokemon_skills[:message]),
               status: :unprocessable_entity
      end
    end

    private

    def params_permit
      params.permit(:name)
    end
  end
end

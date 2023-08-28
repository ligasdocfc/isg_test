# frozen_string_literal: true

module Api
  class PokemonsController < ApplicationController
    def index
      pokemon_skills = FetchPokemonSkillsInteractor.call(name: params[:name])

      if pokemon_skills.success?
        render json: { skills: pokemon_skills }, status: :ok
      else
        render json: errors_serializer(pokemon_skills.errors.full_messages),
               status: :not_found
      end
    end

    private

    def params_permit
      params.permit(:name)
    end
  end
end

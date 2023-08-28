# frozen_string_literal: true

class FetchPokemonSkillsInteractor
  include Mixins::PokemonListInteractor

  attributes :name

  def call
    # fetch_pokemon_skills
  end

  private

  def pokemon_skills
    @pokemon_skills ||= PokemonList::FetchPokemon.fetch_skills(name)
  end

  def fetch_pokemon_skills
    context.fail!(message: I18n.t('errors.pokemon_not_found')) if pokemon_skills.blank?
  end
end

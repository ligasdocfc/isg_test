# frozen_string_literal: true

class FetchPokemonSkillsInteractor
  include Mixins::PokemonListInteractor

  attributes :name

  def call
    fetch_pokemon_skills
  end

  private

  def pokemon
    @pokemon ||= Integrations::PokeApi::Client.new(name).fetch_pokemon
  end

  def fetch_pokemon_skills
    context.fail!(message: I18n.t('errors.pokemon_error')) unless pokemon.success?

    pokemon_skills_name = []
    pokemon['abilities'].each do |pokemon_skill|
      pokemon_skills_name << pokemon_skill['ability']['name']
    end

    context.message = pokemon_skills_name.sort
  end
end

# frozen_string_literal: true

class FetchPokemonAbilitiesInteractor
  include Mixins::PokemonListInteractor

  attributes :name

  def call
    fetch_pokemon_abilities
  end

  private

  def pokemon
    @pokemon ||= Integrations::PokeApi::Client.new(name.downcase).fetch_pokemon
  end

  def fetch_pokemon_abilities
    context.fail!(message: I18n.t('errors.pokemon_error')) unless pokemon.success?

    pokemon_abilities_name = []
    pokemon['abilities'].each do |pokemon_ability|
      pokemon_abilities_name << pokemon_ability['ability']['name']
    end

    context.message = pokemon_abilities_name.sort
  end
end

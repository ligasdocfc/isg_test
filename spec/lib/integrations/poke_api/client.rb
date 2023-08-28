# frozen_string_literal: true

require 'rails_helper'

describe Integrations::PokeApi::Client do
  context 'with success' do
    let!(:name_pokemon) { 'pikachu' }

    it 'test' do
      result = described_class.new(name_pokemon).fetch_pokemon
    end
  end
end

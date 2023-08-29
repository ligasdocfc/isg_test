# frozen_string_literal: true

require 'rails_helper'

describe Integrations::PokeApi::Client do
  context 'when pokemon exists' do
    let!(:name) { 'pikachu' }

    it 'success' do
      VCR.use_cassette('fetch_pokemons_success') do
        result = described_class.new(name).fetch_pokemon

        expect(result).to be_success
        expect(result['abilities']).to be_present
      end
    end
  end
  context 'when pokemon not exists' do
    let!(:name) { 'picachu' }

    it 'failure' do
      VCR.use_cassette('fetch_pokemons_failure') do
        result = described_class.new(name).fetch_pokemon

        expect(result.body).to eq('Not Found')
      end
    end
  end

  context 'when params name is empty' do
    let!(:name) { '' }

    it 'return examples of pokemons' do
      VCR.use_cassette('fetch_pokemons_empty') do
        result = described_class.new(name).fetch_pokemon

        expect(result['results']).to be_present
      end
    end
  end
end

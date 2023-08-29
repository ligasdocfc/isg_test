# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchPokemonAbilitiesInteractor do
  describe '#call' do
    context 'when pokemon exists' do
      let(:name) { 'pikachu' }

      it 'success' do
        VCR.use_cassette('fetch_pokemons_success') do
          result = described_class.call(name:)

          expect(result).to be_success
          expect(result[:message]).to eq(%w[lightning-rod static])
        end
      end
    end

    context 'when pokemon not exists' do
      let(:name) { 'picachu' }

      it 'failure' do
        VCR.use_cassette('fetch_pokemons_failure') do
          result = described_class.call(name:)

          expect(result).to be_failure
          expect(result[:message]).to eq(I18n.t('errors.pokemon_error'))
        end
      end
    end
  end
end

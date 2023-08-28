# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchPokemonSkillsInteractor do
  describe '#call' do
    context 'with valid params' do
      let(:name) { 'pikachu' }

      it 'success' do
        result = described_class.call(name:)

        expect(result).to be_success
        expect(result[:message]).to eq(%w[lightning-rod static])
      end
    end

    context 'with invalid params' do
      let(:name) { 'picachu' }

      it 'failure' do
        result = described_class.call(name:)

        expect(result).to be_failure
        expect(result[:message]).to eq(I18n.t('errors.pokemon_error'))
      end
    end
  end
end

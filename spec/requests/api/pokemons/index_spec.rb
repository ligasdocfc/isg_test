# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API Pokemons Index', type: :request do
  describe 'GET /api/pokemons/{name}' do
    context 'when the params is valid' do
      let(:name) { 'pikachu' }

      it 'returns http status :ok' do
        VCR.use_cassette('fetch_pokemons_success') do
          get "/api/pokemons/#{name}"

          expect(response).to have_http_status(:ok)
        end
      end
    end
    context 'when the params is invalid' do
      let(:name) { 'picachu' }

      it 'returns http status :unprocessable_entity' do
        VCR.use_cassette('fetch_pokemons_failure') do
          get "/api/pokemons/#{name}"

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end

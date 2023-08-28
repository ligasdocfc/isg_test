# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API Pokemons Index', vcr: { cassette_name: 'pokemons/fetch_pokemons' }, type: :request do
  describe 'GET /api/pokemons/{name}' do
    context 'when the params is valid' do
      let(:name) { 'pikachu' }

      it 'returns http status :ok' do
        get "/api/pokemons/#{name}"

        expect(response).to have_http_status(:ok)
      end
    end
    context 'when the params is invalid' do
      let(:name) { 'picachu' }
      it 'returns http status :unprocessable_entity' do
        get "/api/pokemons/#{name}"

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

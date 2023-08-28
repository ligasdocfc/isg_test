# frozen_string_literal: true

module Integrations
  module PokeApi
    class Client
      include HTTParty
      base_uri 'https://pokeapi.co/api/v2/pokemon'

      def initialize(name)
        @name = name
      end

      def fetch_pokemon
        self.class.get("/#{@name}")
      end
    end
  end
end

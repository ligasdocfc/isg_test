# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mixins::PokemonListInteractor do
  subject(:interactor) { TestInteractor.call(params) }

  let(:test_class) do
    Class.new do
      include Mixins::PokemonListInteractor

      attributes :param1, :param2

      def call; end
    end
  end

  before { stub_const('TestInteractor', test_class) }

  describe 'required attributes validation' do
    context 'when all required attributes are present' do
      let(:params) { { param1: 'value1', param2: 'value2' } }

      it { is_expected.to be_success }
    end

    context 'when a required attribute is missing' do
      let(:params) { { param1: 'value1' } }

      it {
        expect do
          interactor
        end.to raise_error(Mixins::PokemonListInteractor::MissingAttributesError, 'Missing required attrs: param2')
      }
    end
  end

  describe 'attribute delegation' do
    before do
      test_class.class_eval do
        def call
          context.result = "#{param1} #{param2}"
        end
      end
    end

    context 'when delegates attributes to the interactor instance' do
      let(:params) { { param1: 'value1', param2: 'value2' } }

      it { expect(interactor.result).to eq('value1 value2') }
    end
  end

  describe 'method overriding protection' do
    let(:params) { { param1: 'value1', param2: 'value2' } }
    let(:test_class) do
      Class.new do
        include Mixins::PokemonListInteractor

        attributes :param1, :param2

        def param1 = 'overridden'

        def call; end
      end
    end

    it {
      expect do
        interactor
      end.to raise_error(Mixins::PokemonListInteractor::MethodOverrideError, 'param1 cannot be overridden')
    }
  end
end

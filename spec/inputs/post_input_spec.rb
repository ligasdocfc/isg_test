# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostInput do
  let(:valid_params) { { title: 'Test Title', text: 'Test Text' } }
  let(:invalid_params) { { title: '', text: '' } }

  describe 'validations' do
    it 'is valid with valid attributes' do
      post_input = described_class.new(valid_params)
      expect(post_input).to be_valid
    end

    it 'is not valid without a title' do
      post_input = described_class.new(invalid_params)
      expect(post_input).not_to be_valid
      expect(post_input.errors[:title]).to include('não pode ficar em branco')
    end

    it 'is not valid without text' do
      post_input = described_class.new(title: 'Test Title', text: '')
      expect(post_input).not_to be_valid
      expect(post_input.errors[:text]).to include('não pode ficar em branco')
    end
  end
end

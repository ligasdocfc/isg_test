# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentInput do
  let(:valid_params) { { name: 'Test Name', comment: 'Test Comment', post_id: '1' } }
  let(:invalid_params) { { name: '', comment: '' } }

  describe 'validations' do
    it 'is valid with valid attributes' do
      post_input = described_class.new(valid_params)
      expect(post_input).to be_valid
    end

    it 'is not valid without a name' do
      post_input = described_class.new(invalid_params)
      expect(post_input).not_to be_valid
      expect(post_input.errors[:name]).to include('não pode ficar em branco')
    end

    it 'is not valid without comment' do
      post_input = described_class.new(name: 'Test Name', comment: '')
      expect(post_input).not_to be_valid
      expect(post_input.errors[:comment]).to include('não pode ficar em branco')
    end
  end
end

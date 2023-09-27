# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  it 'is valid with valid attributes' do
    post = described_class.new(title: 'Test Title', text: 'Test Text', user:)
    expect(post).to be_valid
  end

  it 'is not valid without a title' do
    post = described_class.new(text: 'Test Text', user:)
    expect(post).not_to be_valid
  end

  it 'is not valid without text' do
    post = described_class.new(title: 'Test Title', user:)
    expect(post).not_to be_valid
  end

  it 'belongs to a user' do
    association = described_class.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end
end

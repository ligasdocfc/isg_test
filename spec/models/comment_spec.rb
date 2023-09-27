# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user:) }

  it 'is valid with a name and comment' do
    comment = Comment.new(name: 'John Doe', comment: 'This is a test comment', post:)
    expect(comment).to be_valid
  end

  it 'is invalid without a name' do
    comment = Comment.new(comment: 'This is a test comment')
    expect(comment).to_not be_valid
    expect(comment.errors[:name]).to include('não pode ficar em branco')
  end

  it 'is invalid without a comment' do
    comment = Comment.new(name: 'John Doe')
    expect(comment).to_not be_valid
    expect(comment.errors[:comment]).to include('não pode ficar em branco')
  end

  it 'belongs to a post' do
    post = Post.create(title: 'Sample Post')
    comment = Comment.new(name: 'John Doe', comment: 'This is a test comment', post:)

    expect(comment.post).to eq(post)
  end
end

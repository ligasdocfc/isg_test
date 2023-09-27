# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comments::UpdateCommentInteractor do
  let(:user) { create(:user) }
  let(:post) { create(:post, user:) }
  let(:comment) { create(:comment, post:) }
  let(:valid_comment_params) { { name: 'Updated Name', comment: 'Updated Comment' } }

  describe '#call' do
    context 'with valid comment_params' do
      it 'updates a comment' do
        interactor = described_class.call(user:, comment:, comment_params: valid_comment_params)

        expect(interactor).to be_a_success
        expect(comment.reload.name).to eq('Updated Name')
        expect(comment.reload.comment).to eq('Updated Comment')
      end
    end
  end
end

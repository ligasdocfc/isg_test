# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comments::CreateCommentInteractor do
  let(:user) { create(:user) }
  let(:post) { create(:post, user:) }
  let(:valid_comment_params) { { post_id: post.id, name: 'John Doe', comment: 'Test Comment' } }
  let(:invalid_comment_params) { { post_id: post.id, name: '', comment: '' } }

  describe '#call' do
    context 'with valid comment_params' do
      it 'creates a new comment' do
        interactor = described_class.call(user:, comment_params: valid_comment_params)

        expect(interactor).to be_a_success
      end
    end

    context 'with invalid comment_params' do
      it 'fails and sets errors in the context' do
        interactor = described_class.call(user:, comment_params: invalid_comment_params)

        expect(interactor).to be_a_failure
        expect(interactor.errors).to include('Name não pode ficar em branco', 'Comment não pode ficar em branco')
      end
    end
  end
end

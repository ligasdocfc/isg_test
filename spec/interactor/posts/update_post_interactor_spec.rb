# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::UpdatePostInteractor do
  let(:user) { create(:user) }
  let(:post) { create(:post, user:) }
  let(:valid_post_params) { { title: 'Updated Title', text: 'Updated Text' } }
  let(:invalid_post_params) { { title: '', text: '' } }

  describe '#call' do
    context 'with a valid user and valid post_params' do
      it 'updates the post' do
        interactor = described_class.call(user:, post_params: valid_post_params, post:)

        expect(interactor).to be_a_success
        expect(post.reload.title).to eq('Updated Title')
        expect(post.reload.text).to eq('Updated Text')
      end
    end

    context 'with an invalid user' do
      it 'fails and sets an error message' do
        other_user = create(:user) # Create a different user
        interactor = described_class.call(user: other_user, post_params: valid_post_params, post:)

        expect(interactor).to be_a_failure
        expect(interactor[:message]).to eq(I18n.t('errors.interactors.update_post.check_user'))
      end
    end
  end
end

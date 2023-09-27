# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::CreatePostInteractor do
  let(:user) { create(:user) }
  let(:valid_post_params) { { title: 'Test Title', text: 'Test Text' } }
  let(:invalid_post_params) { { title: '', text: '' } }

  describe '#call' do
    context 'with valid post_params' do
      it 'creates a new post' do
        interactor = Posts::CreatePostInteractor.call(user:, post_params: valid_post_params)

        expect(interactor).to be_a_success
      end
    end

    context 'with invalid post_params' do
      it 'fails and sets errors' do
        interactor = Posts::CreatePostInteractor.call(user:, post_params: invalid_post_params)

        expect(interactor).to be_a_failure
        expect(interactor.errors).to include('Title não pode ficar em branco', 'Text não pode ficar em branco')
      end
    end
  end
end

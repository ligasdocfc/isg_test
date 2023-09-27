# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::PostsController', type: :request do
  let(:user) { create(:user) }

  describe 'POST /api/v1/posts' do
    it 'creates a new post' do
      post_params = { post: { title: 'Test Title', text: 'Test Text' } }
      headers_request_jwt = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      headers = Devise::JWT::TestHelpers.auth_headers(headers_request_jwt, user)

      post '/api/v1/posts', headers:, params: post_params.to_json

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['title']).to eq('Test Title')
      expect(JSON.parse(response.body)['text']).to eq('Test Text')
    end

    it 'returns unprocessable_entity status for invalid post data' do
      headers_request_jwt = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      headers = Devise::JWT::TestHelpers.auth_headers(headers_request_jwt, user)
      invalid_params = { post: { title: '', text: '' } }

      post '/api/v1/posts', headers:, params: invalid_params.to_json

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns unauthorized status' do
      post '/api/v1/posts'

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'PUT /api/v1/posts/:id' do
    let(:post) { create(:post, user:) }

    it 'updates an existing post' do
      headers_request_jwt = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      headers = Devise::JWT::TestHelpers.auth_headers(headers_request_jwt, user)
      update_params = { post: { title: 'Updated Title', text: 'Updated Text' } }

      put "/api/v1/posts/#{post.id}", headers:, params: update_params.to_json

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['title']).to eq('Updated Title')
      expect(JSON.parse(response.body)['text']).to eq('Updated Text')
    end

    it 'returns unauthorized status' do
      update_params = { post: { title: 'Updated Title', text: 'Updated Text' } }

      put "/api/v1/posts/#{post.id}", params: update_params.to_json

      expect(response).to have_http_status(:unauthorized)
    end
  end
end

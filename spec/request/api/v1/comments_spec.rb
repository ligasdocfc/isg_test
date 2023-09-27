# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::CommentsController', type: :request do
  let(:user) { create(:user) }
  let(:post_other) { create(:post, user:) }
  let(:comment) { create(:comment, post: post_other) }

  describe 'POST /api/v1/comments' do
    it 'creates a new comment' do
      comment_params = { comment: { name: 'John Doe', comment: 'Test Comment', post_id: post_other.id } }
      headers_request_jwt = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      headers = Devise::JWT::TestHelpers.auth_headers(headers_request_jwt, user)

      post '/api/v1/comments', headers:, params: comment_params.to_json

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['name']).to eq('John Doe')
      expect(JSON.parse(response.body)['comment']).to eq('Test Comment')
      expect(JSON.parse(response.body)['post']['id']).to eq(post_other.id)
    end

    it 'returns unprocessable_entity status for invalid comment data' do
      headers_request_jwt = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      headers = Devise::JWT::TestHelpers.auth_headers(headers_request_jwt, user)
      invalid_params = { comment: { name: '', comment: '', post_id: post_other.id } }

      post '/api/v1/comments', headers:, params: invalid_params.to_json

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns unauthorized status' do
      post '/api/v1/comments'

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'PUT /api/v1/comments/:id' do
    it 'updates an existing comment' do
      headers_request_jwt = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      headers = Devise::JWT::TestHelpers.auth_headers(headers_request_jwt, user)
      update_params = { comment: { name: 'Updated Name', comment: 'Updated Comment' } }

      put "/api/v1/comments/#{comment.id}", headers:, params: update_params.to_json

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['name']).to eq('Updated Name')
      expect(JSON.parse(response.body)['comment']).to eq('Updated Comment')
    end

    it 'returns not_found status' do
      headers_request_jwt = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      headers = Devise::JWT::TestHelpers.auth_headers(headers_request_jwt, user)
      put("/api/v1/comments/#{Faker::Number.number(digits: 10)}", headers:)

      expect(response).to have_http_status(:not_found)
    end

    it 'returns unauthorized status' do
      put "/api/v1/comments/#{comment.id}"

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'DELETE /api/v1/comments/:id' do
    it 'deletes an existing comment' do
      headers_request_jwt = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      headers = Devise::JWT::TestHelpers.auth_headers(headers_request_jwt, user)
      delete("/api/v1/comments/#{comment.id}", headers:)

      expect(response).to have_http_status(:no_content)
    end

    it 'returns not_found status' do
      headers_request_jwt = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      headers = Devise::JWT::TestHelpers.auth_headers(headers_request_jwt, user)
      delete("/api/v1/comments/#{Faker::Number.number(digits: 10)}", headers:)

      expect(response).to have_http_status(:not_found)
    end

    it 'returns unauthorized status' do
      delete "/api/v1/comments/#{comment.id}"

      expect(response).to have_http_status(:unauthorized)
    end
  end
end

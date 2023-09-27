# frozen_string_literal: true

module Posts
  class DestroyPostInteractor
    include Mixins::IsgTestInteractor

    attributes :user, :post

    def call
      ActiveRecord::Base.transaction do
        destroy_comments
        destroy_post
      end
    end

    private

    def destroy_comments
      comments = Comment.where(post:)

      return if comments.blank?

      comments.destroy_all
    end

    def destroy_post
      post.destroy!
    end
  end
end

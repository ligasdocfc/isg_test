# frozen_string_literal: true
module Posts
  class CreatePostInteractor
    include Mixins::IsgTestInteractor

    attributes :user, :post_params

    def call
      input = PostInput.new(post_params)
      context.fail!(errors: input.errors.full_messages) if input.invalid?

      save_post
    end

    private

    def save_post
      post = Post.new(user:, title: post_params[:title], text: post_params[:text])
      post.save!

      context.success = post
    end
  end
end

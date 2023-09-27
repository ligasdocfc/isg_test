# frozen_string_literal: true

module Comments
  class CreateCommentInteractor
    include Mixins::IsgTestInteractor

    attributes :user, :comment_params

    def call
      input = CommentInput.new(comment_params)
      context.fail!(errors: input.errors.full_messages) if input.invalid?

      save_comment
    end

    private

    def post
      @post ||= Post.find(comment_params[:post_id])
    end

    def save_comment
      comment = Comment.new(post:, name: comment_params[:name], comment: comment_params[:comment])
      comment.save!

      context.success = comment
    end
  end
end

# frozen_string_literal: true

module Comments
  class UpdateCommentInteractor
    include Mixins::IsgTestInteractor

    attributes :user, :comment_params, :comment

    def call
      update_comment
    end

    private

    def post
      @post ||= Post.find_by(comment_params[:post_id]) || comment.post
    end

    def update_comment
      comment.update(post:, name: comment_params[:name], comment: comment_params[:comment])

      context.success = comment
    end
  end
end

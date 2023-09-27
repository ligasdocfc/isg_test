# frozen_string_literal: true

module Api
  module V1
    class CommentsController < UsersController
      before_action :set_comment, only: %i[update destroy]

      def create
        comment = Comments::CreateCommentInteractor.call(
          user: current_user,
          comment_params:
        )

        if comment.success?
          render json: ::Comments::CommentBlueprint.render(comment.success), status: :created
        else
          render json: errors_serializer(comment.errors), status: :unprocessable_entity
        end
      end

      def update
        comment = Comments::UpdateCommentInteractor.call(
          comment: @comment,
          user: current_user,
          comment_params:
        )

        if comment.success?
          render json: ::Comments::CommentBlueprint.render(comment.success), status: :ok
        else
          render json: errors_serializer(comment.errors), status: :unprocessable_entity
        end
      end

      def destroy
        @comment.destroy!
      end

      private

      def set_comment
        @comment = Comment.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit(:name, :comment, :post_id)
      end
    end
  end
end

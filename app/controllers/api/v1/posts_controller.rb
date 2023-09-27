# frozen_string_literal: true

module Api
  module V1
    class PostsController < UsersController
      before_action :set_post, only: %i[update destroy]

      def create
        post = Posts::CreatePostInteractor.call(
          user: current_user,
          post_params:
        )

        if post.success?
          render json: ::Posts::PostBlueprint.render(post.success), status: :created
        else
          render json: errors_serializer(post.errors), status: :unprocessable_entity
        end
      end

      def update
        post = Posts::UpdatePostInteractor.call(
          post: @post,
          user: current_user,
          post_params:
        )

        if post.success?
          render json: ::Posts::PostBlueprint.render(post.success), status: :ok
        else
          render json: errors_serializer(post.errors), status: :unprocessable_entity
        end
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title, :text)
      end
    end
  end
end

# frozen_string_literal: true

module Api
  module V1
    class PostsController < UsersController
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
          id: params[:id].to_i,
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

      def post_params
        params.require(:post).permit(:title, :text)
      end
    end
  end
end

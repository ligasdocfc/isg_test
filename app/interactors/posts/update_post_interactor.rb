# frozen_string_literal: true

module Posts
  class UpdatePostInteractor
    include Mixins::IsgTestInteractor

    attributes :user, :post_params, :id

    def call
      check_user
      update_post
    end

    private

    def post
      @post ||= Post.find(id)
    end

    def check_user
      context.fail!(message: I18n.t('errors.interactors.update_post.check_user')) if user.id != post.user_id
    end

    def update_post
      post.update(title: post_params[:title], text: post_params[:text])

      context.success = post
    end
  end
end

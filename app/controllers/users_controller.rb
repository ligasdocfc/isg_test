# frozen_string_literal: true

class UsersController < ApplicationController
  prepend_before_action { request.env['devise.skip_trackable'] = true }
  before_action :authenticate_user!

  def current_user
    return unless warden.user

    @current_user ||= warden.user
  end
end

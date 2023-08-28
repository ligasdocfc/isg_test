# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def errors_serializer(error_messages)
    return {} if error_messages.blank?

    { errors: error_messages }
  end
end

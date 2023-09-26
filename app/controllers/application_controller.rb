# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :configure_sign_up_params, if: :devise_controller?
  around_action :switch_locale
  include ActionController::MimeResponds
  respond_to :json

  def switch_locale(&)
    locale = I18n.available_locales.include?(params[:locale]&.to_sym) ? params[:locale] : I18n.default_locale
    I18n.with_locale(locale, &)
  end

  def errors_serializer(error_messages)
    return {} if error_messages.blank?

    { errors: error_messages }
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end

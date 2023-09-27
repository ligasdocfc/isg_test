module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
  end

  private

  def render_record_not_found
    render json: { message: I18n.t('errors.record_not_found') }, status: :not_found
  end
end

class Api::V1::BaseController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from StandardError,             with: :render_internal_error

  before_action :authenticate

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      ActiveSupport::SecurityUtils.secure_compare(token, ENV.fetch('API_TOKEN'))
    end
  end

  def render_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def render_internal_error(exception)
    render json: { error: exception.message }, status: :internal_server_error
  end
end

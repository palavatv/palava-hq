class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection

  protect_from_forgery
  after_filter  :set_csrf_cookie_for_ng


  rescue_from Mongoid::Errors::Validations do |e|
    render json: {
      errors:
        e.record.errors.as_json
    }, status: :unprocessable_entity
  end

  rescue_from ActionController::ParameterMissing do |e|
    render json: {
      errors: {
        missing_parameter: e.param
      }
    }, status: :bad_request
  end


  private

  def set_csrf_cookie_for_ng
    cookies['X-XSRF-TOKEN'] = {
      value: form_authenticity_token,
      httponly: true,
      secure: Rails.env.production?,
    } if protect_against_forgery?
  end

  def verified_request?
    super || form_authenticity_token == cookies['X-XSRF-TOKEN']
  end

  def authenticate_confirmed_user!
    authenticate_user!
    not_confirmed unless current_user.confirmed
  end

  def not_authorized
    render json: {
      errors: [
        'not authorized'
      ]
    }, status: :unauthorized
  end

  def not_confirmed
    render json: {
      errors: [
        'not confirmed'
      ]
    }, status: :forbidden
  end
end

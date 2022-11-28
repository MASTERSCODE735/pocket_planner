class ApplicationController < ActionController::API

  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :authenticate_user!, :set_current_tenant!

  def set_current_tenant!
    ActsAsTenant.current_tenant = current_user.user_group if user_signed_in?
  end

  def custom_respond(result = nil)
      response_hash = {
      data: result[:model],
      messages: {
        success: result[:success],
        errors: result[:errors]
      }
    }
    status_code =  result[:http_status_code] || 200
    render json: response_hash, status: status_code
  end

end
class ApplicationController < ActionController::API

  include DeviseTokenAuth::Concerns::SetUserByToken
  
  before_action :authenticate_user!, :set_current_tenant!

  def set_current_tenant!
    ActsAsTenant.current_tenant = current_user.user_group if user_signed_in?
  end

end
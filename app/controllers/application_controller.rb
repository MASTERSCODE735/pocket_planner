class ApplicationController < ActionController::API

  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :authenticate_user!, :set_current_tenant!

  def set_current_tenant!
    if user_signed_in?
      ActsAsTenant.current_tenant = current_user.user_group
    end
  end

end
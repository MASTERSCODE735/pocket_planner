# frozen_string_literal: true

class UsersAuthentication::RegistrationsController < DeviseTokenAuth::RegistrationsController

  skip_before_action :authenticate_user!, :only => [:create]
  before_action :configure_sign_up_params, only: [:create]
  
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new

  # end

  #POST /resource
  def create 
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  #If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    user_group = nil

    unless params[:user_group_owner] && params[:user_group_name]&.present?
      return render json: {
        error: "Bad request provide user group name and owner",
        status: 400
      }
    end

    if UserGroup.find_by(user_group_name: params[:user_group_name]).present?
      return render json: {
        error: "UserGroup already created",
        status: 200
      }
    end

    user_group_created = UserGroup.create(user_group_name: params[:user_group_name])
    params[:user_group_id] = user_group_created.id
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name,
      :last_name,:mobile_number,:user_group_id,:user_group_owner,:email,:password,:password_confirmation])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end

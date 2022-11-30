class WalletsController < ApplicationController
  def index
    result = Wallets::Operation::Index.({params: params, current_user: current_user})
    custom_respond result
  end
  
  def create
    params[:user_id] = current_user&.id
    result = Wallets::Operation::Create.({params: params, current_user: current_user})
    custom_respond result
  end
  
  def show
    result = Wallets::Operation::Show.({params: params})
    custom_respond result
  end
end

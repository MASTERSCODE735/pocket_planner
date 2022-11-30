class TransfersController < ApplicationController

  def index
    result = Transfers::Operation::Index.({params: params, current_user: current_user})
    custom_respond result
  end

  def create

    Transaction.transaction do

      Transfers::Operation::CreateTransferOut.(params: params, current_user: current_user)
      Transfers::Operation::CreateTransferIn.(params: params, current_user: current_user)
      
      render json: {message: "Transaction successfull"}, status: 201
    end
    rescue => exception
      p exception
      raise ActiveRecord::Rollback
      render json: {message: "Transaction failed"}, status: 400

  end

  def show
    result = Transfers::Operation::Show.({params: params, current_user: current_user})
    custom_respond result
  end
  
end
  
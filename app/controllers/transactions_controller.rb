class TransactionsController < ApplicationController
  def index
    result = Transactions::Operation::Index.({params: params, current_user: current_user})
    custom_respond result
  end

  def create
    result = Transactions::Operation::Create.(params: params, current_user: current_user)
    custom_respond result
  end

  def show
    result = Transactions::Operation::Show.({params: params, current_user: current_user})
    custom_respond result
  end
end

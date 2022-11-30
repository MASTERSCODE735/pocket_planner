class ExpensesController < ApplicationController
  def index
    result = Expenses::Operation::Index.({params: params, current_user: current_user})
    custom_respond result
  end

  def create
    result = Expenses::Operation::Create.(params: params, current_user: current_user)
    custom_respond result
  end

  def show
    result = Expenses::Operation::Show.({params: params, current_user: current_user})
    custom_respond result
  end
end
  
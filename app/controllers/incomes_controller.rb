class IncomesController < ApplicationController
    def index
      result = Incomes::Operation::Index.({params: params, current_user: current_user})
      custom_respond result
    end
  
    def create
      params[:user_id] = current_user.id 
      params[:transaction_type_id] = TransactionType.find_by(name: "income").id
      result = Incomes::Operation::Create.(params: params, current_user: current_user)
      custom_respond result
    end
  
    def show
      params[:transaction_type_id] = TransactionType.find_by(name: "income").id
      result = Incomes::Operation::Show.({params: params, current_user: current_user})
      custom_respond result
    end
end
  
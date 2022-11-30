module Expenses::Operation
  class Show < Base::Operation::BaseApiOperation
    
    step Policy::Pundit(Expenses::Policy, :show?)
    step :show_expense
    fail :error!

    def show_expense(ctx, params:, **)
      ctx[:model] = Transaction.where(id: params[:id]).joins(:transaction_type).where(transaction_types: {name: "expense"})
      return false if ctx[:model].empty?
      true
    end

    def error!(ctx, current_user:, **)
      ctx[:http_status_code] = 400
      add_errors ctx,"expense not present"
    end

  end
end
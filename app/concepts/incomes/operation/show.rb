module Incomes::Operation
  class Show < Base::Operation::BaseApiOperation

    step Policy::Pundit(Incomes::Policy, :show?)
    step :show_expense
    fail :error!

    def show_expense(ctx, params:, **)
      ctx[:model] = Transaction.where('id = ? AND transaction_type_id <= ?', params[:id], params[:transaction_type_id])
      return false if ctx[:model].empty?
      true
    end

    def error!(ctx, current_user:, **)
      ctx[:http_status_code] = 400
      add_errors ctx,"income not present"
    end

  end
end
module Incomes::Operation
  class Show < Base::Operation::BaseApiOperation

    step Policy::Pundit(Incomes::Policy, :show?)
    step :show_income
    fail :error!

    def show_income(ctx, params:, **)
      ctx[:model] = Transaction.where(id: params[:id]).joins(:transaction_type).where(transaction_types: {name: "income"})
      return false if ctx[:model].empty?
      true
    end

    def error!(ctx, current_user:, **)
      ctx[:http_status_code] = 400
      add_errors ctx,"income not present"
    end

  end
end
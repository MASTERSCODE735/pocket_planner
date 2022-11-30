module Wallets::Operation
  class Show < Base::Operation::BaseApiOperation

    step Policy::Pundit(Wallets::Policy, :show?)
    step Model(Wallet,:find_by)
    step :show_closing_balance

    def show_closing_balance(ctx, params:, model:, **)
      ctx[:balance] = model.opening_balance + model.in_amount - model.out_amount
      success_message ctx,"Balance is rs.#{ctx[:balance]}"
    end

  end
end
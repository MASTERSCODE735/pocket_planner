module Expenses::Operation
  class Create < Base::Operation::BaseApiOperation
    step Model(Transaction,:new)
    step Policy::Pundit(Expenses::Policy, :create?)
    step Contract::Build(constant: Expenses::Contract::Create)
    step Contract::Validate()
    step :check_wallet_balance
    step Contract::Persist()

    def check_wallet_balance(ctx, params:, current_user:, **)
        unless Wallet.find(params[:wallet_id]).balance > params[:amount].to_f
            add_errors ctx, "Select wallet has insufficient balance"
            return false
        end
        true
    end

  end
end
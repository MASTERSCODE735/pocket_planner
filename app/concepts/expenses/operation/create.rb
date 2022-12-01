module Expenses::Operation
  class Create < Base::Operation::BaseApiOperation

    step :add_transaction_type_user_id
    step Model(Transaction,:new)
    step Policy::Pundit(Expenses::Policy, :create?)
    step Contract::Build(constant: Expenses::Contract::Create)
    step Contract::Validate()
    step :check_wallet_balance
    step Contract::Persist()
    fail :error!

    def add_transaction_type_user_id(ctx, params:, current_user:, **)
      params[:user_id] = current_user.id
      params[:transaction_type_id] = TransactionType.id_for(:expense)
    end

    def check_wallet_balance(ctx, params:, current_user:, **)
      
      wallet = Wallet.find(params[:wallet_id])
      calculate_balance = wallet.opening_balance + wallet.in_amount - wallet.out_amount

      unless  calculate_balance > params[:amount].to_f
        add_errors ctx, "Select wallet has insufficient balance"
        return false
      end
      true
    end

    def error!(ctx, **)
      error_messages= []
      error_messages << ctx["contract.default"]&.errors&.messages
      add_errors ctx, error_messages
    end

  end
end
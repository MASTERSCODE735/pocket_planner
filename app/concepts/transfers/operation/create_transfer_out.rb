require 'date'
module Transfers::Operation
  class CreateTransferOut < Base::Operation::BaseApiOperation
    
    step :add_transaction_type_user_id
    step Model(Transaction,:new)
    step Policy::Pundit(Incomes::Policy, :create?)
    step Contract::Build(constant: Transfers::Contract::Create)
    step Contract::Validate()
    step :check_wallet_balance
    step Contract::Persist()
    fail :error!

    def add_transaction_type_user_id(ctx, params:, current_user:, **)
      params[:date] = DateTime.now
      params[:wallet_id] = params[:from_wallet_id]
      params[:user_id] = current_user.id
      params[:transaction_type_id] = TransactionType.id_for(:tranfer_out)
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

  end
end
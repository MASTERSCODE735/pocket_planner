module Transactions::Operation
  class Create < Base::Operation::BaseApiOperation
    step Model(Transaction,:new)
    step Contract::Build(constant: Transactions::Contract::Create)
    step Contract::Validate()
    step :check_wallet_balance
    step :create_transaction
    step Contract::Persist()

    def check_wallet_balance(ctx, params:, current_user:, **)
        if params[:from_wallet_id]
            if Wallet.find(params[:from_wallet_id]).balance < params[:amount].to_f
                add_errors ctx, "Select wallet has insufficient balance"
                return false
            end
        end
        true
    end

    def create_transaction(ctx, params:, current_user:, **)
        if params[:transaction_type_id].to_i == TransactionType.id_for(:expense) && params[:category_id].present?
            Transaction.transaction do
                begin
                    create_transaction = Transaction.create!(name: params[:name],date: params[:date],
                    category_id: params[:category_id],transaction_type_id: params[:transaction_type_id],
                    wallet_id: params[:from_wallet_id],amount: params[:amount], user_id: current_user.id,
                    user_group_id: current_user.user_group_id)
                    create_transaction.lock!
                    ctx[:model] = create_transaction

                    selected_wallet = Wallet.find(params[:from_wallet_id])
                    update_balance = selected_wallet.balance - params[:amount].to_f
                    selected_wallet.lock!
                    selected_wallet.update(balance: update_balance)
                    success_message ctx,"Expense Successfully Created"
                    return true
                rescue ActiveRecord::StatementInvalid
                    raise ActiveRecord::Rollback
                end
            end
        elsif params[:transaction_type_id].to_i == TransactionType.id_for(:income)
            Transaction.transaction do
                begin
                    create_transaction = Transaction.create!(name: params[:name],date: params[:date],
                    transaction_type_id: params[:transaction_type_id],
                    wallet_id: params[:wallet_id],
                    amount: params[:amount],
                    user_id: current_user.id, user_group_id: current_user.user_group_id)
                    create_transaction.lock!
                    ctx[:model] = create_transaction

                    selected_wallet = Wallet.find(params[:wallet_id])

                    update_balance = selected_wallet.opening_balance + params[:amount].to_f
                    selected_wallet.lock!
                    selected_wallet.update(opening_balance: update_balance, balance: update_balance)
                    success_message ctx,"Amount Successfully Added"
                    return true
                rescue ActiveRecord::StatementInvalid
                    raise ActiveRecord::Rollback
                end

            end
        elsif params[:from_wallet_id] && params[:to_wallet_id] 
            Transaction.transaction do
                begin
                    create_transaction1 = Transaction.create!(name: params[:name],date: params[:date],
                    transaction_type_id: 4,wallet_id: params[:from_wallet_id],
                    user_id: current_user.id,user_group_id: current_user.user_group_id,
                    amount: params[:amount])
                    create_transaction1.lock!

                    create_transaction2 = Transaction.create!(name: params[:name],date: params[:date],
                    transaction_type_id: 3,wallet_id: params[:to_wallet_id],
                    user_id: current_user.id,user_group_id: current_user.user_group_id,
                    amount: params[:amount])
                    create_transaction2.lock!
                    ctx[:model] = create_transaction1
                    ctx[:model] = create_transaction2

                    from_wallet = Wallet.find(params[:from_wallet_id])
                    to_wallet = Wallet.find(params[:to_wallet_id])
                    update_balance1 = from_wallet.balance - params[:amount].to_f
                    from_wallet.lock!
                    from_wallet.update( balance: update_balance1)

                    update_balance2 = to_wallet.balance + params[:amount].to_f
                    to_wallet.lock!
                    to_wallet.update( balance: update_balance2)
          
                    success_message ctx,"Amount Successfully Transfered"
                    return true
                rescue ActiveRecord::StatementInvalid
                    raise ActiveRecord::Rollback
                end
            end
        end
        true
    end

  end
end
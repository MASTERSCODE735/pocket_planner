class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :transaction_type
  belongs_to :wallet

  acts_as_tenant :user_group

  scope :filter_expense_name, -> (name) { where('name like ?',"%#{name}%")}
  scope :filter_income_name, -> (name) { where('name like ?',"%#{name}%")}

  after_save :update_wallet

  def update_wallet
    begin
      Wallet.transaction do
        transaction = Transaction.last
        wallet = Wallet.find_by(id: transaction.wallet_id)
        if transaction.transaction_type_id == TransactionType.find_by(name: "expense").id || transaction.transaction_type_id == TransactionType.find_by(name: "transfer_out").id
          wallet.out_amount = wallet.out_amount + transaction.amount
          closing_balance = (wallet.opening_balance + wallet.in_amount) -  wallet.out_amount
        elsif transaction.transaction_type_id == TransactionType.find_by(name: "income").id || transaction.transaction_type_id == TransactionType.find_by(name: "transfer_in").id
          if wallet.opening_balance == 0
            wallet.opening_balance = transaction.amount 
            wallet.in_amount = 0 
            wallet.out_amount = 0
            closing_balance = transaction.amount
          else
            wallet.in_amount = wallet.in_amount + transaction.amount
            closing_balance = (wallet.opening_balance + wallet.in_amount) - wallet.out_amount
          end
        end
        wallet.update(balance: closing_balance)
      end
    rescue => exception
      p exception
      raise ActiveRecord::Rollback
      return false
    end
  end
end

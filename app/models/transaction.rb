class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :transaction_type
  belongs_to :wallet

  acts_as_tenant :user_group

  scope :filter_expense_name, -> (name) { where('name like ?',"%#{name}%") }
  scope :filter_income_name, -> (name) { where('name like ?',"%#{name}%") }

  after_save :update_wallet_balance

  def update_wallet_balance
    Wallet.transaction do
      transaction = self
      wallet = Wallet.find_by(id: transaction.wallet_id)
      wallet.lock!
     
      if TransactionType.find(transaction.transaction_type_id).multiplier == -1
        total_in_amount = wallet.in_amount  
        total_out_amount = wallet.out_amount + transaction.amount
      else
        total_in_amount = wallet.in_amount + transaction.amount 
        total_out_amount = wallet.out_amount
      end
     
      wallet.update(in_amount: total_in_amount,out_amount: total_out_amount)

      logger.info "wallet amount updated"
      return true
    end
    rescue => exception
      raise ActiveRecord::Rollback
      logger.info "wallet not saved raised the following exception-#{exception}"
      return false
  end
end

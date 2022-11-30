class RemoveBalanceToWallets < ActiveRecord::Migration[6.0]
  def change
    remove_column :wallets, :balance
  end
end

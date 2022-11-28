class RemoveNullToWallets < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:wallets, :balance, true)
    change_column_null(:wallets, :opening_balance, true)
  end
end

class AddNotUsersToWallets < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:wallets, :user_id, false)
  end
end

class AddUserGroupToWallets < ActiveRecord::Migration[6.0]
  def change
    add_reference :wallets, :user_group, null: false, foreign_key: true
  end
end

class AddUsersToWallet < ActiveRecord::Migration[6.0]
  def change
    add_reference :wallets, :user, foreign_key: true
  end
end

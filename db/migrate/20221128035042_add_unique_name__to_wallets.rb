class AddUniqueNameToWallets < ActiveRecord::Migration[6.0]
  def change
    change_column :wallets, :name, :string, unique: true
  end
end

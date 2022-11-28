class CreateWallets < ActiveRecord::Migration[6.0]
  def change
    create_table :wallets do |t|
      t.string :name, null: false
      t.decimal :balance, default: 0, null: false, precision: 20, scale: 5
      t.decimal :opening_balance, default: 0, null: false, precision: 20, scale: 5
      t.decimal :in_amount, default: 0, null: false, precision: 20, scale: 5
      t.decimal :out_amount, default: 0, null: false, precision: 20, scale: 5

      t.timestamps
    end
  end
end

class AddAmountToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :amount, :decimal, precision: 20, scale: 5, null: false
  end
end

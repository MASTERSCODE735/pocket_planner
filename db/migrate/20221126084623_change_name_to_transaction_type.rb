class ChangeNameToTransactionType < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:transaction_types, :name, false)
    change_column_null(:transaction_types, :multiplier, false)
  end
end

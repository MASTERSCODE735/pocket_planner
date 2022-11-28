class AddNullToCategoryTransactions < ActiveRecord::Migration[6.0]
  def change
    change_column :transactions, :category_id, :bigint, default: 0
  end
end

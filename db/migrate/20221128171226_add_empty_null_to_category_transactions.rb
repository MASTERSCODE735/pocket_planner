class AddEmptyNullToCategoryTransactions < ActiveRecord::Migration[6.0]
  def change
    change_column :transactions, :category_id, :bigint, default: :null
  end
end

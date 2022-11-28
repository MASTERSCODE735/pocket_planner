class AddEmaptyToCategoryTransactions < ActiveRecord::Migration[6.0]
  def change
    change_column :transactions, :category_id, :bigint, default: ""
  end
end

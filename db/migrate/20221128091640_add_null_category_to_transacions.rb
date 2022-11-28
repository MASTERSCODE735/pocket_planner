class AddNullCategoryToTransacions < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:transactions, :category_id, true)
  end
end

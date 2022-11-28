class CreateBudgets < ActiveRecord::Migration[6.0]
  def change
    create_table :budgets do |t|
      t.string :budget_name, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.belongs_to :category, null: false, foreign_key: true
      t.belongs_to :user_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end

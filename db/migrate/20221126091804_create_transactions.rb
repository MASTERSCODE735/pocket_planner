class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :name, default: "", null: false
      t.datetime :date, null: false
      t.belongs_to :user_group, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :category, null: false, foreign_key: true
      t.belongs_to :transaction_type, null: false, foreign_key: true
      t.belongs_to :wallet, null: false, foreign_key: true

      t.timestamps
    end
  end
end

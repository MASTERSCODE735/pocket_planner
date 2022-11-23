class CreateUserGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :user_groups do |t|
      t.string :user_group_name,:null => false, :default => ""

      t.timestamps
    end
  end
end

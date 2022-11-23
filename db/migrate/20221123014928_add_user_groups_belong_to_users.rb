class AddUserGroupsBelongToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :user_group, null: false, foreign_key: true
  end
end

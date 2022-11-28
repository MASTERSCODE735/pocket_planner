class UserGroup < ApplicationRecord
  validates :user_group_name, uniqueness: true
  
  has_many :users
  has_many :categories
  has_many :transactions
  has_many :budgets
  has_many :wallets
end

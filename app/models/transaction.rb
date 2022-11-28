class Transaction < ApplicationRecord
  belongs_to :user_group
  belongs_to :user
  belongs_to :category
  belongs_to :transaction_type
  belongs_to :wallet
  
  acts_as_tenant :user_group
end

class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :transaction_type
  belongs_to :wallet
  
  acts_as_tenant :user_group
end

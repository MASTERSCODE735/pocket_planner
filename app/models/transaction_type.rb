class TransactionType < ApplicationRecord
  acts_as_tenant :user_group
end

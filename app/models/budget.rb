class Budget < ApplicationRecord
  belongs_to :category
  belongs_to :users
  acts_as_tenant :user_group
end

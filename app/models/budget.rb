class Budget < ApplicationRecord
  validates :budget_name, uniqueness: true
  belongs_to :category
  acts_as_tenant :user_group
end

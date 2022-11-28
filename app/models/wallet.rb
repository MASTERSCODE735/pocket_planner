class Wallet < ApplicationRecord
  validates :name, uniqueness: true
  belongs_to :user
  has_many :transactions
  acts_as_tenant :user_group

  scope :filter_wallet_name, -> (name) { where('name like ?',"%#{name}%")}
end

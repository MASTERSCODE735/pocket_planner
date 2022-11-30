class Category < ApplicationRecord
  validates :name, uniqueness: true
  acts_as_tenant :user_group

  scope :filter_category_name, -> (name) { where('name like ?',"%#{name}%")}

end

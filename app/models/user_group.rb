class UserGroup < ApplicationRecord
    validates :user_group_name, uniqueness: true
end

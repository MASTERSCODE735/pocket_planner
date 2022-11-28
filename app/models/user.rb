# frozen_string_literal: true

class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  belongs_to :user_group, optional: true
  has_many :transactions
  has_many :wallets
  
  acts_as_tenant :user_group
  scope :filter_name, -> (name) { where('first_name like ? OR last_name like ?',"%#{name}%","%#{name}%")}
end

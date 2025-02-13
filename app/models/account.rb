class Account < ApplicationRecord
  # acts_as_tenant

  # has_one :user, dependent: :destroy
  has_many :companies, dependent: :destroy
  has_many :users, through: :companies
end

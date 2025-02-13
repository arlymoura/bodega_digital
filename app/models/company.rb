class Company < ApplicationRecord
  acts_as_tenant(:account)

  # belongs_to :account
  # has_many :memberships
  # has_many :users, through: :memberships

  # has_many :virtual_carts, dependent: :destroy
  # has_many :carts, dependent: :destroy
  # has_many :products, dependent: :destroy
  # has_many :categories, dependent: :destroy
  # has_many :orders, dependent: :destroy
  # has_many :order_items, dependent: :destroy
  # has_many :stocks, dependent: :destroy
  # has_many :stock_items, dependent: :destroy

  # default_scope -> { where(account: ActsAsTenant.current_tenant) }

  belongs_to :account
  has_many :memberships
  has_many :users, through: :memberships
  # has_many :customers, through: :customer_companies
  has_many :products
end

class Cart < ApplicationRecord
  belongs_to :account
  belongs_to :company
  has_one :order

  has_many :cart_items, dependent: :destroy
end

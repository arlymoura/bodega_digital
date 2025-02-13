class Order < ApplicationRecord
  enum status: { open: 0, processing: 1, ready: 2, canceled: 3 }
  enum kind: { table_order: 0, pickup: 1, delivery: 2 }

  belongs_to :company
  belongs_to :account
  belongs_to :cart
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy
  has_many :payment, dependent: :destroy

  validates :kind, :status, presence: true
end

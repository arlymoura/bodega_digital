class Order < ApplicationRecord
  enum status: { open: 0, processing: 1, ready: 2, canceled: 3 }
  enum kind: { table_order: 0, pickup: 1, delivery: 2 }

  belongs_to :table, optional: true
  belongs_to :member, optional: true
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy
  has_one :payment, dependent: :destroy

  validates :kind, :status, presence: true
  validates :customer_name, presence: true, if: -> { kind != "table_order" }
end

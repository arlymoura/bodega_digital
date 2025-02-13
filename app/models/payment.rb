class Payment < ApplicationRecord
  enum status: { pending: 0, completed: 1, failed: 2 }
  enum payment_method: { cash: 0, card: 1, pix: 2, other: 3 }

  belongs_to :order
  belongs_to :company
  belongs_to :account

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :payment_method, presence: true
end

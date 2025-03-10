# frozen_literal: true

class StockItem < ApplicationRecord
  belongs_to :account
  belongs_to :company
  belongs_to :variant
  belongs_to :stock
  has_one :product, through: :variant

  # validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  scope :with_active_stock, lambda {
    joins(:stocks).where(stocks: { status: :active })
  }

  def low_stock?
    quantity <= min_quantity
  end

  def adjust_stock(amount)
    update!(quantity: quantity + amount)
  end
end

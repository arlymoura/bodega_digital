class OrderItem < ApplicationRecord
  before_save :calculate_total_price

  belongs_to :order
  belongs_to :product_variant

  validates :quantity, :unit_price, :total_price, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  private

  def calculate_total_price
    self.total_price = quantity * unit_price
  end
end

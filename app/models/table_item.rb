class TableItem < ApplicationRecord
  belongs_to :table
  belongs_to :product_variant

  validates :quantity, presence: true, numericality: { greater_than: 0 }
end

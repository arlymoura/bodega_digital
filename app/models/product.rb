# frozen_literal: true

class Product < ApplicationRecord
  belongs_to :category
  has_many :product_variants, dependent: :destroy
  has_many :stock_items, through: :product_variants
  has_many :stocks, through: :stock_items

  accepts_nested_attributes_for :product_variants, allow_destroy: true

  enum kind: { shoes: 1, food: 2, drink: 3, clothes: 4, electronics: 5, other: 6 }
  enum status: { active: 0, disabled: 1, out: 2 }

  has_one_attached :thumbnail
end

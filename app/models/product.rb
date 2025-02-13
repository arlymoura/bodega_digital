# frozen_literal: true

class Product < ApplicationRecord
  acts_as_tenant(:company)

  belongs_to :account
  belongs_to :company
  belongs_to :category
  has_many :variants, dependent: :destroy
  has_many :stock_items, through: :variants
  has_many :stocks, through: :stock_items

  accepts_nested_attributes_for :variants, allow_destroy: true

  enum kind: { shoes: 1, food: 2, drink: 3, clothes: 4, electronics: 5, other: 6 }
  enum status: { active: 0, disabled: 1, out: 2 }

  has_one_attached :thumbnail
end

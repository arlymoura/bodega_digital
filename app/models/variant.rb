# frozen_literal: true

class Variant < ApplicationRecord
  include ProductVariantDataGenerator
  include ImageResizer
  after_save :resize_and_store_imagens, if: :photo_attached?

  belongs_to :account
  belongs_to :company
  belongs_to :product
  has_many :stock_items, dependent: :destroy
  has_many :stocks, through: :stock_items

  has_one_attached :thumbnail
  has_many_attached :imagens
  # validates :sku, uniqueness: true, presence: true
  validates :properties, presence: true

  accepts_nested_attributes_for :stock_items, allow_destroy: true

  enum status: { active: 0, disabled: 1, scheduled: 2 }

  # Validação personalizada para atributos dinâmicos
  # validate :validate_properties

  scope :with_active_stock, lambda {
    joins(stock_items: :stock).where(stocks: { status: :active })
  }

  def price
    stock_item_price = stock_items&.first&.price
    return self[:price] || 0 if stock_item_price.zero?

    stock_item_price
  end

  private

  def photo_attached?
    imagens&.first&.attached?
  end
end

# frozen_literal: true

class ProductVariant < ApplicationRecord
  include ProductVariantDataGenerator
  include ImageResizer
  after_save :resize_and_store_imagens, if: :photo_attached?

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

  # def validate_properties
  #   case product.kind
  #   when "shoe"
  #     errors.add(:properties, "must include size") unless properties["size"]
  #     errors.add(:properties, "must include color") unless properties["color"]
  #   when "shirt"
  #     errors.add(:properties, "must include size and fit") unless properties["size"] && properties["fit"]
  #   else
  #     # Permitir flexibilidade para outros tipos de produtos
  #   end
  # end
  def photo_attached?
    imagens&.first&.attached?
  end
end

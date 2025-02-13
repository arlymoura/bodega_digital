# app/models/concerns/variant_data_generator.rb
module ProductVariantDataGenerator
  extend ActiveSupport::Concern

  included do
    before_validation :generate_sku, :generate_ean13, :generate_barcode, on: [:create, :update]

    validates :sku, uniqueness: true, presence: true
    validates :ean, uniqueness: true, presence: true
    validates :barcode, uniqueness: true, presence: true
  end

  private

  def generate_sku
    return if sku.present?

    loop do
      self.sku = SecureRandom.hex(6)
      break unless Variant.exists?(sku: sku)
    end
  end

  def generate_ean13
    return if ean.present?

    loop do
      self.ean = BarcodeGenerator.generate_ean13
      break unless Variant.exists?(ean: ean)
    end
  end

  def generate_barcode
    return if barcode.present?

    loop do
      self.barcode = SecureRandom.hex(6)
      break unless Variant.exists?(barcode: barcode)
    end
  end
end

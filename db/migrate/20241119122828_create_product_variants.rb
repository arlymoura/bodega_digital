class CreateProductVariants < ActiveRecord::Migration[7.0]
  def change
    create_table :product_variants, id: :uuid do |t|
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.string :sku
      t.string :barcode
      t.string :ean
      t.jsonb :properties
      t.integer :status
      t.decimal :price

      t.timestamps
    end
  end
end

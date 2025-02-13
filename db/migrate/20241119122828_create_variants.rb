class CreateVariants < ActiveRecord::Migration[7.0]
  def change
    create_table :variants, id: :uuid do |t|
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.string :sku
      t.string :barcode
      t.string :ean
      t.jsonb :properties
      t.integer :status

      t.float :height
      t.float :width
      t.float :weight
      t.float :length
      t.string :gtin
      t.string :mpn
      t.string :ncm
      t.string :code
      t.string :slug

      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :company, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

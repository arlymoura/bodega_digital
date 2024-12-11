class CreateStockItems < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_items, id: :uuid do |t|
      t.references :product_variant, null: false, foreign_key: true, type: :uuid
      t.references :stock, null: false, foreign_key: true, type: :uuid
      t.integer :min_quantity, default: 0
      t.integer :quantity, default: 0
      t.decimal :price, default: 0

      t.timestamps
    end
  end
end

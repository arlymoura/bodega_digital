class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items, id: :uuid do |t|
      t.references :order, null: false, foreign_key: true, type: :uuid
      t.references :product_variant, null: false, foreign_key: true, type: :uuid
      t.integer :quantity
      t.decimal :unit_price
      t.decimal :total_price

      t.timestamps
    end
  end
end

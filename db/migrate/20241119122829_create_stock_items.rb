class CreateStockItems < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_items, id: :uuid do |t|
      t.integer :min_quantity, default: 0
      t.integer :quantity, default: 0
      t.decimal :price, default: 0
      
      t.references :variant, null: false, foreign_key: true, type: :uuid
      t.references :stock, null: false, foreign_key: true, type: :uuid
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :company, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end

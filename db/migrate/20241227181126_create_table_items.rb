class CreateTableItems < ActiveRecord::Migration[7.0]
  def change
    create_table :table_items, id: :uuid do |t|
      t.references :table, null: false, foreign_key: true, type: :uuid
      t.references :product_variant, null: false, foreign_key: true, type: :uuid
      t.integer :quantity

      t.timestamps
    end
  end
end

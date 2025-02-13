class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items, id: :uuid do |t|
      t.references :cart, null: false, foreign_key: true, type: :uuid
      t.references :variant, null: false, foreign_key: true, type: :uuid
      t.integer :quantity

      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :company, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end

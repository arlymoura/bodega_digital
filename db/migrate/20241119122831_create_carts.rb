class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts, id: :uuid do |t|
      t.references :virtual_carts, null: false, foreign_key: true, type: :uuid

      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :company, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end

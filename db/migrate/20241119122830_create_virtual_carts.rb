class CreateVirtualCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :virtual_carts, id: :uuid do |t|

      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :company, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end

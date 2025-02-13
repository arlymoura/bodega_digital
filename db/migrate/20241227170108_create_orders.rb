class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.string :customer_name
      t.integer :kind
      t.integer :status
      t.decimal :total_price
      t.references :user, null: true, foreign_key: true, type: :uuid
      t.references :customer, null: true, foreign_key: true, type: :uuid
      

      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :company, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end

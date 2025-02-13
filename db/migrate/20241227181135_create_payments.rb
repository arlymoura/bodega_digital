class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments, id: :uuid do |t|
      t.references :order, null: false, foreign_key: true, type: :uuid
      t.decimal :amount
      t.string :payment_method
      t.integer :status

      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :company, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end

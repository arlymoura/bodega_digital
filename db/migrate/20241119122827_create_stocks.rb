class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks, id: :uuid do |t|
      t.string :name
      t.string :description
      t.integer :status, default: 0

      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :company, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

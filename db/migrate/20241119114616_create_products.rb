class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.references :category, null: false, foreign_key: true, type: :uuid
      t.integer :kind
      t.integer :status

      t.timestamps
    end
  end
end

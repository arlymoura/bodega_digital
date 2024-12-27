class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :tables, id: :uuid do |t|
      t.integer :number
      t.integer :status
      t.boolean :is_virtual, default: false, null: false

      t.timestamps
    end
  end
end

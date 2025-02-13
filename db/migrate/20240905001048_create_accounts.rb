class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts, id: :uuid do |t|
      # t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :name

      t.timestamps
    end
  end
end

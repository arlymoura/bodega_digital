class AddCurrentCompanyToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :current_company, null: true, foreign_key: { to_table: :companies }, type: :uuid
  end
end

class AddCurrentTimeToAdmin < ActiveRecord::Migration[7.0]
  def change
    add_reference :admins, :current_time, type: :uuid, foreign_key: { to_table: :teams }, null: true
  end
end

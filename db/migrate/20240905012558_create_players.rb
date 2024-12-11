class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players, id: :uuid do |t|
      t.string :name
      t.date :birthdate
      t.string :position
      t.string :status
      t.date :joined_on
      t.date :left_on
      t.references :team, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

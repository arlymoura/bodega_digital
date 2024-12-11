class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams, id: :uuid do |t|
      t.string :name
      t.date :founded_on
      t.string :location
      t.text :history

      t.timestamps
    end
  end
end

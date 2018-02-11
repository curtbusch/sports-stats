class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :teamId
      t.integer :jersey_number
      t.string :position

      t.timestamps
    end
  end
end

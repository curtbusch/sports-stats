class AddLeagueFkToTeam < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :league_id, :int
  end
end

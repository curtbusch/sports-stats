class CreateCoaches < ActiveRecord::Migration[5.1]
  def change
    create_table :coaches do |t|
      t.string :name
      t.boolean :isHeadCoach
      t.integer :teamId
      t.string :college

      t.timestamps
    end
  end
end

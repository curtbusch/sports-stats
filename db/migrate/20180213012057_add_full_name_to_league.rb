class AddFullNameToLeague < ActiveRecord::Migration[5.1]
  def change
    add_column :leagues, :fullname, :string
  end
end

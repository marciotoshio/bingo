class AddMasterToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :master, :boolean
  end
end

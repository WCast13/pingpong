class AddLeagueidToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_reference :players, :league, foreign_key: true
  end
end

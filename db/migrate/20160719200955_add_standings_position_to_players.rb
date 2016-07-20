class AddStandingsPositionToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :standings_position, :integer
  end
end

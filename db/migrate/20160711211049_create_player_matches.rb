class CreatePlayerMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :player_matches, id: false do |t|
      t.belongs_to :player, index: true
      t.belongs_to :match, index: true

      t.timestamps
    end
  end
end

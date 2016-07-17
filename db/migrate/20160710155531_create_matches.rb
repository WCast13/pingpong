class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.string :opponent_username
      t.integer :your_score
      t.integer :opponent_score
      t.timestamps
    end
  end
end

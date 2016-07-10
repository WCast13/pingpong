class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.string :winners_slack_name
      t.string :losers_slack_name
      t.integer :winners_score
      t.integer :losers_score

      t.timestamps
    end
  end
end

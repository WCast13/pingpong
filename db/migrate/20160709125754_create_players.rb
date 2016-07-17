class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :user_name
      t.string :password_digest
      t.timestamps
    end
  end
end

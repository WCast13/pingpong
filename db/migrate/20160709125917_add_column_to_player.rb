class AddColumnToPlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :wins, :integer
    add_column :players, :losses, :integer
    add_column :players, :pf, :integer
    add_column :players, :pa, :integer
  end
end

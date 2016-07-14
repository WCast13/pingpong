class AddWinPercentageToPlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :win_percentage, :float
  end
end

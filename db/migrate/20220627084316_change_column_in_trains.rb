class ChangeColumnInTrains < ActiveRecord::Migration[6.1]
  def change
    change_column :trains, :max_weight, :float
    change_column :trains, :max_volume, :float
  end
end

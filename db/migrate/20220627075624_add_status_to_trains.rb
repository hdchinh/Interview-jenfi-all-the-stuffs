class AddStatusToTrains < ActiveRecord::Migration[6.1]
  def change
    add_column :trains, :status, :integer, default: 0
  end
end

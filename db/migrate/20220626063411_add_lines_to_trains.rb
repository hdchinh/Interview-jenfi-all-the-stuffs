class AddLinesToTrains < ActiveRecord::Migration[6.1]
  def change
    add_column :trains, :lines, :jsonb, default: []
  end
end

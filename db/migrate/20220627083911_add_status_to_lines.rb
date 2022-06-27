class AddStatusToLines < ActiveRecord::Migration[6.1]
  def change
    add_column :lines, :status, :integer, default: 0
  end
end

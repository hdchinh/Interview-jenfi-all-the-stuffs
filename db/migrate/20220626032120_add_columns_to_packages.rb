class AddColumnsToPackages < ActiveRecord::Migration[6.1]
  def change
    add_column :packages, :weight, :integer
    add_column :packages, :volume, :integer
  end
end

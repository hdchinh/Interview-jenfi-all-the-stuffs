class ChangeColumnInPackages < ActiveRecord::Migration[6.1]
  def change
    change_column :packages, :weight, :float
    change_column :packages, :volume, :float
  end
end

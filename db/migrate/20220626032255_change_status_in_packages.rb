class ChangeStatusInPackages < ActiveRecord::Migration[6.1]
  def change
    change_column :packages, :status, :integer, default: 0
  end
end

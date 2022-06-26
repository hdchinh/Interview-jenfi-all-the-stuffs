class AddLineToPackages < ActiveRecord::Migration[6.1]
  def change
    add_reference :packages, :line, null: false, foreign_key: true
  end
end

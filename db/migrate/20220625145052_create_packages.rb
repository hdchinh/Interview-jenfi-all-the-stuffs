class CreatePackages < ActiveRecord::Migration[6.1]
  def change
    create_table :packages do |t|
      t.references :customer, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end

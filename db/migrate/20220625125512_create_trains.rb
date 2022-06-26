class CreateTrains < ActiveRecord::Migration[6.1]
  def change
    create_table :trains do |t|
      t.integer :max_weight
      t.integer :max_volume
      t.float :cost
      t.references :train_operator, null: false, foreign_key: true

      t.timestamps
    end
  end
end

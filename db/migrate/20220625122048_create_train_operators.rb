class CreateTrainOperators < ActiveRecord::Migration[6.1]
  def change
    create_table :train_operators do |t|
      t.string :name
      t.integer :total_trains, default: 0
      t.string :api_key

      t.timestamps
    end
  end
end

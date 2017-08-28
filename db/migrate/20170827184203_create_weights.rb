class CreateWeights < ActiveRecord::Migration[5.1]
  def change
    create_table :weights do |t|
      t.integer :user_id
      t.float :amount
      t.datetime :date
      t.timestamps
    end
  end
end

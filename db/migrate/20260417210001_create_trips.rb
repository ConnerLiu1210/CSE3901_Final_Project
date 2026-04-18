class CreateTrips < ActiveRecord::Migration[7.1]
  def change
    create_table :trips do |t|
      t.string :name, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
    add_index :trips, :user_id
  end
end

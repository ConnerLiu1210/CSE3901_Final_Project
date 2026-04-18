class CreateTripMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :trip_memberships do |t|
      t.integer :trip_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
    add_index :trip_memberships, [:trip_id, :user_id], unique: true
  end
end

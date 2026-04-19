class RemoveUserFromTrips < ActiveRecord::Migration[7.1]
  def change
    remove_reference :trips, :user, null: false, foreign_key: true
  end
end

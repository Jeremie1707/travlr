class AddTripsRefToInvites < ActiveRecord::Migration[5.2]
  def change
    remove_column :invites, :trip_id, :integer
    add_reference :invites, :trip, foreign_key: true
  end
end

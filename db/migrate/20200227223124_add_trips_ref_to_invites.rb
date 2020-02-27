class AddTripsRefToInvites < ActiveRecord::Migration[5.2]
  def change
    add_reference :invites, :trip, foreign_key: true
  end
end

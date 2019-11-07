class AddTripIdFromInvites < ActiveRecord::Migration[5.2]
  def change
    add_column :invites, :trip_id, :integer
  end
end

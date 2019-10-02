class AddColumnsToTrip < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :location, :string
    add_column :trips, :name, :string
  end
end

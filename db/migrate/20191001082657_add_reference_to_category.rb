class AddReferenceToCategory < ActiveRecord::Migration[5.2]
  def change
    add_reference :trip_items, :category, foreign_key: true
  end
end

class CreateTripItems < ActiveRecord::Migration[5.2]
  def change
    create_table :trip_items do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.date :start_date
      t.date :end_date
      t.text :description
      t.integer :price
      t.string :photo
      t.string :link
      t.boolean :confirmed
      t.references :user, foreign_key: true
      t.references :trip, foreign_key: true

      t.timestamps
    end
  end
end

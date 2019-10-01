class CreateParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :participants do |t|
      t.references :trip, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

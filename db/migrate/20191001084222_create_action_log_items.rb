class CreateActionLogItems < ActiveRecord::Migration[5.2]
  def change
    create_table :action_log_items do |t|
      t.string :event_type
      t.references :trip_item, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

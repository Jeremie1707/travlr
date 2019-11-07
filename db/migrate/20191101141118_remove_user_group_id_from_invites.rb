class RemoveUserGroupIdFromInvites < ActiveRecord::Migration[5.2]

  def up
    remove_column :invites, :user_group_id
  end

  def down
    add_column :invites, :trip_id, :integer
  end

end

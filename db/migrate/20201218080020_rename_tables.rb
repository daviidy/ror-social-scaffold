class RenameTables < ActiveRecord::Migration[5.2]
  def change
    rename_column :follows, :follower_id, :user_id
    rename_column :follows, :leader_id, :friend_id
    rename_table :follows, :friendships
  end
end

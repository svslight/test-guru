class DropTableBadgesUsers < ActiveRecord::Migration[6.0]
  def up
    drop_table :badges_users, if_exists: true
  end
end

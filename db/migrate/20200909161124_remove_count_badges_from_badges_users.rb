class RemoveCountBadgesFromBadgesUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :badges_users, :count_badges, :integer
  end
end

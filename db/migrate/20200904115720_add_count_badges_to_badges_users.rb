class AddCountBadgesToBadgesUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :badges_users, :count_badges, :integer, default: 1
  end
end

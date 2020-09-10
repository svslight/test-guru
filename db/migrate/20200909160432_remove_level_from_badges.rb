class RemoveLevelFromBadges < ActiveRecord::Migration[6.0]
  def change
    remove_column :badges, :level, :integer
  end
end

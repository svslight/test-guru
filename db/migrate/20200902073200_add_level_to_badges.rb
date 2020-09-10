class AddLevelToBadges < ActiveRecord::Migration[6.0]
  def change
    add_column :badges, :level, :integer
  end
end

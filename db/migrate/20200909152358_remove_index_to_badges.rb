class RemoveIndexToBadges < ActiveRecord::Migration[6.0]
  def change
    remove_column :badges, :badge_rule_id
  end
end

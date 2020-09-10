class DropTableBadgeRules < ActiveRecord::Migration[6.0]
  def change
    drop_table :badges_rules, if_exists: true
  end
end

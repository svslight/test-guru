class AddBadgeRulesNullConstraint < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:badge_rules, :rule, false)
    change_column_null(:badge_rules, :description, false)
  end
end

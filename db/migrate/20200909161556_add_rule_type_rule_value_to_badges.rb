class AddRuleTypeRuleValueToBadges < ActiveRecord::Migration[6.0]
  def change
    add_column :badges, :rule_type, :string, default: ''
    add_column :badges, :rule_value, :string, default: ''
  end
end

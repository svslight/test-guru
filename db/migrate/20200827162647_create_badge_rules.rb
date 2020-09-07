class CreateBadgeRules < ActiveRecord::Migration[6.0]
  def change
    create_table :badge_rules do |t|
      t.string :rule
      t.text :description

      t.timestamps
    end
  end
end

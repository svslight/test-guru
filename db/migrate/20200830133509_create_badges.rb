class CreateBadges < ActiveRecord::Migration[6.0]
  def change
    create_table :badges do |t|
      t.string :title, null: false, unique: true
      t.string :image, null: false
      t.references :badge_rule, foreign_key: true

      t.timestamps
    end
  end
end

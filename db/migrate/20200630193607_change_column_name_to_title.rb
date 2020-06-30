class ChangeColumnNameToTitle < ActiveRecord::Migration[6.0]
  def change
    rename_column :categories, :name, :title
  end
end

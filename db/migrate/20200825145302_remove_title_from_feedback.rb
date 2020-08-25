class RemoveTitleFromFeedback < ActiveRecord::Migration[6.0]
  def change
    remove_column :feedbacks, :title, :string
  end
end

class AddBodyToAnswers < ActiveRecord::Migration[6.0]
  def change
    add_column :answers, :body, :text
  end
end

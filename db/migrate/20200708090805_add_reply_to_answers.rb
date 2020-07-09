class AddReplyToAnswers < ActiveRecord::Migration[6.0]
  def change
    add_column :answers, :reply, :string
  end
end

class AddAnswersReplyNullConstraint < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:answers, :reply, false)
  end
end

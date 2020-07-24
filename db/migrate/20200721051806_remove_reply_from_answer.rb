class RemoveReplyFromAnswer < ActiveRecord::Migration[6.0]
  def change
    remove_column :answers, :reply, :string
  end
end

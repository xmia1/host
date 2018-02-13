class AddMarkWorkInProgressToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :mark_work_in_progress, :boolean
  end
end

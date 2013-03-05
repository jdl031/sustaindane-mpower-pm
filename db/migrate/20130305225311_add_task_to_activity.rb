class AddTaskToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :task_id, :integer
  end
end

class AddGoalDateToProject < ActiveRecord::Migration
  def change
    add_column :projects, :goal_date, :datetime
  end
end

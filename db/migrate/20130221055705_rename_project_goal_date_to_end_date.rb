class RenameProjectGoalDateToEndDate < ActiveRecord::Migration
  def up
    rename_column :projects, :goal_date, :end_date
  end

  def down
    rename_column :projects, :end_date, :goal_date
  end
end

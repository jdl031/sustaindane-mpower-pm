class AddStartDateToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :start_date, :datetime
  end
end

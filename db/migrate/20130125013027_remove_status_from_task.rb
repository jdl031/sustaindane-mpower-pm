class RemoveStatusFromTask < ActiveRecord::Migration
  def up
    remove_column :tasks, :status
  end

  def down
    add_column :tasks, :status, :string
  end
end

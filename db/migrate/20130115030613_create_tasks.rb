class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :project
      t.references :creator
      t.references :owner
      t.string :title
      t.string :description
      t.datetime :due
      t.string :status

      t.timestamps
    end
    add_index :tasks, :project_id
    add_index :tasks, :creator_id
    add_index :tasks, :owner_id
  end
end

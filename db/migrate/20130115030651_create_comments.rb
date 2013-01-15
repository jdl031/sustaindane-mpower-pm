class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :task
      t.references :user
      t.string :comment

      t.timestamps
    end
    add_index :comments, :task_id
    add_index :comments, :user_id
  end
end

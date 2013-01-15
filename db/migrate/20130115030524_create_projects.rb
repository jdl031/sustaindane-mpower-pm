class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references :company
      t.string :name

      t.timestamps
    end
    add_index :projects, :company_id
  end
end

class AddActiveToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :active, :boolean
  end
end

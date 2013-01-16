class Project < ActiveRecord::Base
  belongs_to :company
  attr_accessible :name, :company_id

  has_many :tasks
end

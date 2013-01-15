class Project < ActiveRecord::Base
  belongs_to :company
  attr_accessible :name

  has_many :tasks
end

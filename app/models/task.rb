class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :creator
  belongs_to :owner
  attr_accessible :description, :due, :status, :title

  has_many :comments
end

class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :creator, :class_name => 'User'
  belongs_to :owner, :class_name => 'User'
  attr_accessible :project_id, :creator_id, :owner_id, :description, :due, :status, :title

  has_many :comments
end

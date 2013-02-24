class Task < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  belongs_to :project
  belongs_to :creator, :class_name => 'User'
  belongs_to :owner, :class_name => 'User'
  attr_accessible :project_id, :creator_id, :owner_id, :description, :due, :complete, :title

  has_many :comments
end

class Project < ActiveRecord::Base
  belongs_to :company
  attr_accessible :name, :company_id, :goal_date, :description

  has_many :tasks

  def completion
  	tasks.where(:complete => true).length.to_f / (tasks.length > 0 ? tasks.length : 1)
  end
end

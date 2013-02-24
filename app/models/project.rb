class Project < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  belongs_to :company
  attr_accessible :name, :company_id, :start_date, :end_date, :description

  has_many :tasks

  def completion
  	tasks.where(:complete => true).length.to_f / (tasks.length > 0 ? tasks.length : 1)
  end
end

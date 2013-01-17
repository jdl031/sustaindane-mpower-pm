class Project < ActiveRecord::Base
  belongs_to :company
  attr_accessible :name, :company_id

  has_many :tasks

  def completion
  	tasks.where(:status => 'complete').length.to_f / tasks.length
  end
end

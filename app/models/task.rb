class Task < ActiveRecord::Base
  include PublicActivity::Model
  tracked

  belongs_to :project
  belongs_to :creator, :class_name => 'User'
  belongs_to :owner, :class_name => 'User'
  attr_accessible :project_id, :creator_id, :owner_id, :description, :due, :complete, :title

  has_many :comments

  def ical_event
    e=Icalendar::Event.new
    e.uid='company:'+self.project.company.id.to_s+':project:'+self.project.id.to_s+':task:'+self.id.to_s
    e.dtstart=DateTime.civil(self.due.year, self.due.month, self.due.day, self.due.hour, self.due.min)
    e.dtend=DateTime.civil(self.due.year, self.due.month, self.due.day, self.due.hour, self.due.min)
    e.summary=self.title
    e.created=DateTime.civil(self.created_at.year, self.created_at.month, self.created_at.day, self.created_at.hour, self.created_at.min)
    e.last_modified=DateTime.civil(self.updated_at.year, self.updated_at.month, self.updated_at.day, self.updated_at.hour, self.updated_at.min)
    e
  end
end

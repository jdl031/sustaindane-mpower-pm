class Project < ActiveRecord::Base
  include PublicActivity::Model
  tracked

  belongs_to :company
  attr_accessible :name, :company_id, :start_date, :end_date, :description

  has_many :tasks

  def completion
  	tasks.where(:complete => true).length.to_f / (tasks.length > 0 ? tasks.length : 1)
  end

  def ical
    calendar = Icalendar::Calendar.new
    calendar.custom_property('X-WR-CALNAME', self.name)
    self.tasks.each do |task|
      calendar.add task.ical_event
    end
    calendar
  end

  def ical_event
    e=Icalendar::Event.new
    e.uid='company:'+self.company.id.to_s+'project:'+self.id.to_s
    e.dtstart=DateTime.civil(self.start_date.year, self.start_date.month, self.start_date.day, self.start_date.hour, self.start_date.min)
    e.dtend=DateTime.civil(self.end_date.year, self.end_date.month, self.end_date.day, self.end_date.hour, self.end_date.min)
    e.summary=self.name
    e.created=DateTime.civil(self.created_at.year, self.created_at.month, self.created_at.day, self.created_at.hour, self.created_at.min)
    e.last_modified=DateTime.civil(self.updated_at.year, self.updated_at.month, self.updated_at.day, self.updated_at.hour, self.updated_at.min)
    e
  end
end

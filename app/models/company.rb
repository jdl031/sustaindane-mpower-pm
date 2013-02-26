class Company < ActiveRecord::Base
  attr_accessible :name, :active

  has_many :projects

  def ical
    calendar = Icalendar::Calendar.new
    puts calendar
    self.projects.each do |project|
      e=Icalendar::Event.new
      e.uid='company:'+self.id.to_s+'project:'+project.id.to_s
      e.dtstart=DateTime.civil(project.start_date.year, project.start_date.month, project.start_date.day, project.start_date.hour, project.start_date.min)
      e.dtend=DateTime.civil(project.end_date.year, project.end_date.month, project.end_date.day, project.end_date.hour, project.end_date.min)
      e.summary=project.name
      e.created=DateTime.civil(project.created_at.year, project.created_at.month, project.created_at.day, project.created_at.hour, project.created_at.min)
      e.last_modified=DateTime.civil(project.updated_at.year, project.updated_at.month, project.updated_at.day, project.updated_at.hour, project.updated_at.min)
      calendar.add e
    end
    calendar
  end
end

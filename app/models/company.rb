class Company < ActiveRecord::Base
  attr_accessible :name, :active

  has_many :projects

  def ical
    calendar = Icalendar::Calendar.new
    puts calendar
    self.projects.each do |project|
      e=Icalendar::Event.new
      e.uid=project.id
      e.dtstart=DateTime.civil(project.start_date.year, project.start_date.month, project.start_date.day, project.start_date.hour, project.start_date.min)
      e.dtend=DateTime.civil(project.end_date.year, project.end_date.month, project.end_date.day, project.end_date.hour, project.end_date.min)
      e.summary=project.name
      e.created=project.created_at
      e.last_modified=project.updated_at
      calendar.add e
    end
    calendar
  end
end

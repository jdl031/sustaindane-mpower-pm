class Company < ActiveRecord::Base
  attr_accessible :name, :active

  has_many :projects

  def ical
    calendar = Icalendar::Calendar.new
    calendar.custom_property('X-WR-CALNAME', self.name)
    self.projects.each do |project|
      calendar.add project.ical_event
    end
    calendar
  end
end

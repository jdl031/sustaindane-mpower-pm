class Project < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

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
      e=Icalendar::Event.new
      e.uid='company:'+self.company.id.to_s+':project:'+self.id.to_s+':task:'+task.id.to_s
      e.dtstart=DateTime.civil(task.due.year, task.due.month, task.due.day, task.due.hour, task.due.min)
      e.dtend=DateTime.civil(task.due.year, task.due.month, task.due.day, task.due.hour, task.due.min)
      e.summary=task.title
      e.created=DateTime.civil(task.created_at.year, task.created_at.month, task.created_at.day, task.created_at.hour, task.created_at.min)
      e.last_modified=DateTime.civil(task.updated_at.year, task.updated_at.month, task.updated_at.day, task.updated_at.hour, task.updated_at.min)
      calendar.add e
    end
    calendar
  end
end

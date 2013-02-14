class Company < ActiveRecord::Base
  attr_accessible :name, :active

  has_many :projects
end

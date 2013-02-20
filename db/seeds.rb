# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
['admin', 'company_admin', 'user'].each do |role|
  Role.find_or_create_by_name role
end

['Human Resources', 'IT', 'Logistics'].each do |department|
  Department.find_or_create_by_name department
end

# @todo: insert default admin user (TOTALLY INSECURE!)

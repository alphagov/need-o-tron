# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
audiences = ['Everyone', 'Businesses', 'Professionals', 'Politicians/Govt', 'Parents', 'Carers', 'Young people', 'Disabled people', 'Overseas', 'Older people']
audiences.each { |a| Audience.find_or_create_by_name(a) }

['Guide', 'Answer', 'Custom App', 'Decision Tree', 'Transaction (link)', 'Find nearest'].each do |kind|
  Kind.find_or_create_by_name(kind)
end

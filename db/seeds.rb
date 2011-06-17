# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
audiences = ['Everyone', 'Businesses', 'Professionals', 'Politicians/Govt', 'Parents', 'Carers', 'Young people', 'Disabled people', 'Overseas', 'Older people']
audiences.each { |a| Audience.find_or_create_by_name(a) }

["Search behaviour", "User request", "Legal framework", "Govt obligation", "Official channel", "Govt campaign"].each do |et_name|
  EvidenceType.find_or_create_by_name(et_name)
end

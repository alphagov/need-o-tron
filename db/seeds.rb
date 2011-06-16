# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
departments = ['Attorney General\'s Office', 'Cabinet Office', 'Department for Business, Innovation and Skills', 'Department for Communities and Local Government', 'Department for Culture, Media and Sport', 
  'Department for Education', 'Department of Energy and Climate Change', 'Department for Environment, Food and Rural Affairs', 'Department for International Development', 
  'Department for Transport', 'Department for Work and Pensions', 'Department of Health', 'Foreign and Commonwealth Office', 'Government Equalities Office', 'HM Treasury', 'Home Office', 
  'Ministry of Defence', 'Ministry of Justice', 'Northern Ireland Office', 'Number 10', 'Office of the Advocate General for Scotland', 'Office of the Leader of the House of Commons', 
  'Office of the Leader of the House of Lords', 'Privy Council Office', 'Scotland Office', 'Wales Office', 'OFGEM', 'Food Standards Agency', 'Health and Safety Executive (HSE)', 
  'Intellectual Property Office', 'Charity Commission', 'Highways Agency', 'Acas (Advisory, Conciliation and Arbitration Service)', 'Adjudicator\'s Office', 
  'Animal Health and Veterinary Laboratories Agency (AHVLA)', 'Association of National Park Authorities', 'Association of Police Authorities', 'Audit Commission', 'Better Regulation Executive', 
  'Bona Vacantia Division (Treasury Solicitor\'s Department)', 'UK Border Agency', 'Boundary Commission for England', 'Boundary Commission for Northern Ireland', 'Boundary Commission for Scotland', 
  'Boundary Commission for Wales', 'BRB (Residuary) Ltd', 'British Waterways Board', 'Office for Budget Responsibility (OBR)', 'Business Link', 'Buying Solutions', 'Care Quality Commission', 
  'Central Office of Information', 'Child Support Agency', 'The Coal Authority', 'Companies House', 'Competition Appeal Tribunal (CAT)', 'Competition Commission', 'Natural England', 
  'Criminal Records Bureau', 'Crown Estate', 'Crown Prosecution Service', 'Debt Management Office', 'Drinking Water Inspectorate', 'Electoral Commission', 'Employment Tribunals', 
  'Enterprise and Business Support', 'Environment Agency', 'European Consumer Centre for Services', 'European Ombudsman', 'National Health Service (NHS)', 'Office of Fair Trading', 
  'Financial Ombudsman Service', 'Financial Services Authority', 'Fire Service College', 'Food and Environment Research Agency', 'Forensic Science Service', 'Forestry Commission', 
  'Gambling Appeals Tribunal', 'Gambling Commission', 'General Register Office', 'General Register Office for Northern Ireland', 'Government Actuaries Department', 
  'Government Banking Service (GBS)', 'Office of Government Commerce', 'Government Communications Headquarters (GCHQ)', 'Her Majesty\'s Inspectorate of Constabulary', 
  'Her Majesty\'s Inspectorate of Education', 'Her Majesty\'s Inspectorate of Prisons', 'Her Majesty\'s Inspectorate of Probation', 'Her Majesty\'s Prison Service', 
  'Identity and Passport Service (IPS)', 'Independent Case Examiner', 'Independent Living Fund', 'Independent Police Complaints Commission', 'Insolvency Service', 'Jobcentre Plus', 
  'Judicial Committee of the Privy Council', 'Land Registry', 'The Upper Tribunal (Lands Chamber)', 'Legal Ombudsman', 'Legal Services Ombudsman', 'Local Government Ombudsman', 
  'Local Government Ombudsman (Wales)', 'London Development Agency', 'Maritime and Coastguard Agency', 'Medicines and Healthcare Products Regulatory Agency', 'Met Office', 'MI5 (Security Service)', 
  'Money Advice Service', 'The National Archives', 'National Assembly for Wales', 'National Audit Office', 'National Probation Service', 'National Policing Improvement Agency (NPIA)', 
  'National Savings and Investments', 'National School of Government', 'Office for National Statistics (ONS)', 'Ofcom (Office of Communications)', 'Office for National Statistics', 
  'Office for Standards in Education (OFSTED)', 'Office of Leader of the House of Commons', 'Office of Rail Regulation', 'Office of Tax Simplification (OTS)', 
  'Office of the Information Commissioner', 'Office of the Parliamentary and Health Service Ombudsman', 'Office of the Public Guardian', 'Office of Water Services (OFWAT)', 
  'Ofqual', 'Olympic Delivery Authority', 'Ordnance Survey', 'Ordnance Survey of Northern Ireland', 'Pensions Ombudsman', 'The Pension Service', 'Planning Inspectorate', 'Postcomm', 
  'Prisons and Probation Ombudsman', 'Privy Council Office', 'Qualifications and Curriculum Authority (QCA)', 'Residential Property Tribunal Service', 'Royal Mint', 'Royal Parks Agency', 
  'Rural Payments Agency', 'Serious Fraud Office', 'Serious Organised Crime Agency (SOCA)', 'Skills Funding Agency', 'UK Space Agency', 'Stabilisation Unit', 
  'Training and Development Agency for Schools', 'Transport Scotland', 'Treasury Solicitor\'s Department (TSOL)', 'Her Majesty\'s Courts and Tribunals Service', 
  'UK Border Agency - Visa Services Directorate', 'UK Home Civil Service', 'UK Office of the European Parliament', 'UK Resilience', 'UK Trade and Investment', 
  'Universities and Colleges Admission Service (UCAS)', 'Vehicle and Operator Services Agency (VOSA)', 'Vehicle Certification Agency (VCA)', 'Service Personnel & Veterans Agency (SPVA)', 
  'Veterinary Medicines Directorate', 'Wales Audit Office', 'Welsh Assembly Government', 'Whole of Government Accounts', 'Young People\'s Learning Agency', 'Youth Justice Board', 'Zoos Expert Committee']
departments.each { |d| Department.find_or_create_by_name(d) }
audiences = ['Businesses', 'Professionals', 'Politicians/Govt', 'Parents', 'Carers', 'Young people', 'Disabled people', 'Overseas', 'Older people']
audiences.each { |a| Audience.find_or_create_by_name(a) }
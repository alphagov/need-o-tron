namespace :import do
  desc "Import google doc (exported to CSV) specified by the file environment variable"
  task :google_doc_2011_10_20 => :environment do
    # Clean up departments data a little
    Department.find_or_create_by_name('GDS')
    Department.find_or_create_by_name('DWP-Pensions')
    Department.find_or_create_by_name('Her Majesty\'s Revenue and Customs')
    Department.find_or_create_by_name('Department for Environment, Food and Rural Affairs')
    Department.find_or_create_by_name('DVLA')
    Department.find_or_create_by_name('Veterans Agency')
    
    department_translations = {
      'dclg' => 'Department for Communities and Local Government',
      'bis' => 'Department for Business',
      'mok' => 'Ministry of Justice',
      'beta' => 'GDS',
      'hmrc' => 'Her Majesty\'s Revenue and Customs',
      'dfe' => 'Department for Education',
      'defra' => 'Department for Environment, Food and Rural Affairs',
      'dwp' => 'Department for Work and Pensions',
      'fco' => 'Foreign and Commonwealth Office',
      'dft' => 'Department for Transport',
      'ukba' => 'UK Border Agency',
      'ho' => 'Home Office',
      'hse' => 'Health and Safety Executive (HSE)',
      'dh' => 'Department of Health',
      'moj' => 'Ministry of Justice',
      'co' => 'Cabinet Office',
      'oft' => 'Office of Fair Trading',
      'fsa' => 'Financial Services Authority',
      'mod' => 'Ministry of Defence',
      'hmt' => "HM Treasury",
      'dcms' => 'Department for Culture',
      'va' => 'Veterans Agency'
    }
    file_path = Rails.root.join('db/imports/2011_10_20.csv')

    require 'csv'
    CSV.foreach(file_path, :headers => true) do |row|
      begin
        need = Need.find(row['ID'])
      
        writing_department_name = department_translations[row['Writing dept'].strip.downcase] || row['Writing dept'].strip
        writing_department = Department.find_by_name(writing_department_name)

        policy_departments = (row['Policy departments'] || "").split(',').collect do |pd_name|
          pd_name.strip!
          next if pd_name == 'Not assigned' or pd_name == 'Multiple' or pd_name == 'unknown' or pd_name == 'wide range of owners' or pd_name == 'Monarchy'
        
          policy_department_name = department_translations[pd_name.downcase] || pd_name.strip
          Department.find_by_name(policy_department_name)
        end
      
        fact_check_emails = (row['Fact checker'] || "").match(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i).to_a
        fact_check_contacts = fact_check_emails.collect { |e| Contact.find_or_create_by_email(e) }
      
        if writing_department
          need.writing_department = writing_department 
        else
          need.writing_department_id = nil
        end
      
        if policy_departments.any?
          need.policy_departments = policy_departments
        else
          need.policy_departments.clear
        end
      
        if fact_check_contacts.any?
          need.fact_check_contacts = fact_check_contacts
        else
          need.fact_check_contacts.clear
        end
      
        need.save!
      rescue ActiveRecord::RecordNotFound
        puts "Couldn't find or process need #{row['ID']}"
      end
      
    end
  end
end
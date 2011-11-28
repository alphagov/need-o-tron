object @need
attribute :title, :status, :url, :description, :notes, :tag_list
                                                     
code(:kind){|n| n.kind.name rescue "none" }          

child :writing_department => :writing_team do
  attribute :id, :name
end

child :fact_check_contacts => :fact_checkers do
  attribute :id, :email
end              

child :policy_departments => :policy_owners do
  attribute :id, :name
end
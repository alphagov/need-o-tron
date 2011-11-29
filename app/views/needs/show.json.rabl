object @need
attribute :title, :status, :url, :description, :notes, :tag_list
                                                     
code(:kind){|n| n.kind.name rescue "none" }          

child :writing_department => :writing_team do
  attribute :id, :name
end
                                  
child :fact_checkers => :fact_checkers do
  attribute :email
end                        

child :policy_departments => :policy_owners do
  attribute :id, :name
end
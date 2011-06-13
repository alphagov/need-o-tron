class Justification < ActiveRecord::Base
  belongs_to :need
  belongs_to :evidence_type
  
  mount_uploader :file, EvidenceFileUploader
end

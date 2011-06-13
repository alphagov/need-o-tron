class Justification < ActiveRecord::Base
  belongs_to :need
  
  mount_uploader :file, EvidenceFileUploader
end

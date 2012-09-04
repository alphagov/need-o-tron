class Justification < ActiveRecord::Base
  belongs_to :need
  belongs_to :evidence_type

  validates :evidence_type, :presence => true

  # This uploader has been disabled until we can do a bit more work on
  # verifying the format of files and checking them for viruses
  # mount_uploader :file, EvidenceFileUploader
end

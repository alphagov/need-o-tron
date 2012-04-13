class Justification < ActiveRecord::Base
  belongs_to :need
  belongs_to :evidence_type

  validates :evidence_type, :presence => true

  mount_uploader :file, EvidenceFileUploader
end

class EvidenceType < ActiveRecord::Base
  has_many :justifications
  validate :name, :presence => true

  def to_s
    name
  end
end

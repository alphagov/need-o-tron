class Kind < ActiveRecord::Base
  has_many :needs

  def to_s
    name
  end
end

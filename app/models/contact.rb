class Contact < ActiveRecord::Base
  has_many :fact_checkers
end

class Assignment < ActiveRecord::Base
  
  belongs_to :person
  belongs_to :location

  validates_uniqueness_of :location, scope: :role

end

class Business < ActiveRecord::Base
  belongs_to :user
  has_many :raffles
  
  
end

class Raffle < ActiveRecord::Base
  belongs_to :business
  
  has_one :prize
  has_many :tickets
  
  validates :business_id, :presence => true
  validates :target_url, :presence => true
  validates :end_date, :presence => true
  validates :contact_name, :presence => true
  validates :contact_no, :presence => true
  
 

end

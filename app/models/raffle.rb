class Raffle < ActiveRecord::Base
  belongs_to :business
  has_one :prize
  has_many :tickets
end

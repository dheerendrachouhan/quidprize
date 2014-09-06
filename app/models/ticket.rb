class Ticket < ActiveRecord::Base
  belongs_to :user, foreign_key: "owner"
  belongs_to :raffle, foreign_key: "raffle_id"
  has_many :referrals, class_name: "Ticket", foreign_key: "parent_ticket"
  belongs_to :referring_ticket, class_name: "Ticket"
end


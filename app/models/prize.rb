class Prize < ActiveRecord::Base
  belongs_to :raffle
  belongs_to :user, :foreign_key => 'winner'
end


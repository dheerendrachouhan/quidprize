class RenameRaffleFieldInTicketTable < ActiveRecord::Migration
  def change
    rename_column :tickets, :raffle, :raffle_id
  end
end

class RenameHashInTicketTable < ActiveRecord::Migration
  def change
    rename_column :tickets, :hash, :hash_str
  end
end

class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :raffle
      t.integer :owner
      t.string :hash
      t.integer :parent_ticket

      t.timestamps
    end
  end
end

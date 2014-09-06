class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      t.string :description
      t.string :type
      t.float :amount
      t.integer :winner
      t.boolean :status

      t.timestamps
    end
  end
end

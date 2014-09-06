class CreateRaffles < ActiveRecord::Migration
  def change
    create_table :raffles do |t|
      t.integer :business_id
      t.string :target_url
      t.datetime :end_date
      t.integer :prize_id
      t.boolean :status

      t.timestamps
    end
  end
end

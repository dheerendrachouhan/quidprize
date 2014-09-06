class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :logo
      t.integer :user

      t.timestamps
    end
  end
end

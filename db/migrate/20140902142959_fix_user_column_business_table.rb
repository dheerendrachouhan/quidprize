class FixUserColumnBusinessTable < ActiveRecord::Migration
  def change
    rename_column :businesses, :user, :user_id
  end
end

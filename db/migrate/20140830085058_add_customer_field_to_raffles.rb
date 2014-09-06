class AddCustomerFieldToRaffles < ActiveRecord::Migration
  def change
    add_column :raffles, :contact_name, :string
    add_column :raffles, :contact_no, :string
  end
end

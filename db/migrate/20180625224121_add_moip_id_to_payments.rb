class AddMoipIdToPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :moip_id, :string
  end
end

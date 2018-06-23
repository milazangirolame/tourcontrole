class AddMoipIdToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :moip_id, :string
    add_column :orders, :status, :string
    add_column :orders, :platform, :string
  end
end

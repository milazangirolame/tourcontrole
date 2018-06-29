class RemoveOrderTotalFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :order_total
    remove_column :orders, :platform
  end
end

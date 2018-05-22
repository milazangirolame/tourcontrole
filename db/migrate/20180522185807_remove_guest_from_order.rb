class RemoveGuestFromOrder < ActiveRecord::Migration[5.1]
  def change
    remove_column :booking_orders, :guest_id
    remove_column :booking_orders, :buyer
  end
end

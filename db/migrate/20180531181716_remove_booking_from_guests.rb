class RemoveBookingFromGuests < ActiveRecord::Migration[5.1]
  def change
    remove_column :guests, :booking_order_id
  end
end

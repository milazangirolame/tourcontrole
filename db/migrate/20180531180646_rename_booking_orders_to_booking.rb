class RenameBookingOrdersToBooking < ActiveRecord::Migration[5.1]
  def change
    rename_table :booking_orders, :bookings
  end
end

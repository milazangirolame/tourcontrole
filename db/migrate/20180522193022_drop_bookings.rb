class DropBookings < ActiveRecord::Migration[5.1]
  def change
    drop_table :bookings
  end
end

class RemoveActivityFromBookings < ActiveRecord::Migration[5.1]
  def change
    remove_reference :bookings, :activity, foreign_key: true
  end
end

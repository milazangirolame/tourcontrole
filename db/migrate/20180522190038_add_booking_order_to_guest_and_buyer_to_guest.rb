class AddBookingOrderToGuestAndBuyerToGuest < ActiveRecord::Migration[5.1]
  def change
    add_column :guests, :buyer, :boolean, null: false, default: false
    add_reference :guests, :booking_order, foreign_key: true
  end
end

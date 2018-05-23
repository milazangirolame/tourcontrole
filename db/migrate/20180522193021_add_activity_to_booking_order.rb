class AddActivityToBookingOrder < ActiveRecord::Migration[5.1]
  def change
    add_reference :booking_orders, :activity, foreign_key: true
  end
end

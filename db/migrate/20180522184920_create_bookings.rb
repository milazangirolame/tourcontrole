class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.references :booking_order, foreign_key: true
      t.references :activity, foreign_key: true

      t.timestamps
    end
  end
end

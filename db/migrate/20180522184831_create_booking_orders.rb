class CreateBookingOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :booking_orders do |t|
      t.references :guest, foreign_key: true
      t.boolean :buyer, default: false, null: false
      t.timestamps
    end
  end
end

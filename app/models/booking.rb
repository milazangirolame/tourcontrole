class Booking < ApplicationRecord
  belongs_to :booking_order
  belongs_to :activity
end

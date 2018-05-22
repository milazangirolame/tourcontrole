class BookingOrder < ApplicationRecord
  has_many :guests
  has_one :booking
end

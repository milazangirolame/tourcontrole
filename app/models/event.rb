class Event < ApplicationRecord
  belongs_to :activity
  has_many :bookings
  has_many :guests, through: :bookings
end

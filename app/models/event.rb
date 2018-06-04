class Event < ApplicationRecord
  belongs_to :activity
  has_many :bookings, dependent: :destroy
  has_many :guests, through: :bookings
end

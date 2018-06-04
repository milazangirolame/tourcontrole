class Order < ApplicationRecord
  has_many :bookings
  has_many :events,through: :bookings
  has_many :guests, through: :bookings, class_name: 'Guest'
  accepts_nested_attributes_for :bookings
  accepts_nested_attributes_for :guests
end

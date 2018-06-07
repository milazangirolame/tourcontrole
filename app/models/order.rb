class Order < ApplicationRecord
  has_many :bookings, inverse_of: :order
  has_many :events,through: :bookings
  has_many :guests, through: :bookings, class_name: 'Guest'
  accepts_nested_attributes_for :bookings, allow_destroy: true
  accepts_nested_attributes_for :guests
  validates_associated :bookings, :guests
  attr_accessor :terms
end

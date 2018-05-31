class Order < ApplicationRecord
  has_many :bookings
  has_many :guests, through: :bookings, inverse_of: :guest
  accepts_nested_attributes_for :guests,  reject_if: :all_blank, allow_destroy: true
end

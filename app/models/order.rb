class Order < ApplicationRecord
  has_many :bookings, inverse_of: :order
  has_many :events,through: :bookings, inverse_of: :order
  has_many :guests, through: :bookings, inverse_of: :order, class_name: 'Guest'
  accepts_nested_attributes_for :bookings,  reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :guests,  reject_if: :all_blank, allow_destroy: true
end

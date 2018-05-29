class BookingOrder < ApplicationRecord
  has_many :guests, inverse_of: :booking_order
  belongs_to :activity
  accepts_nested_attributes_for :guests,  reject_if: :all_blank, allow_destroy: true
end

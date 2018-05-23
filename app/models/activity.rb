class Activity < ApplicationRecord
  belongs_to :tour_store
  has_many :photos, dependent: :destroy
  has_many :booking_orders
  has_many :guests, through: :booking_orders
  accepts_nested_attributes_for :photos

end

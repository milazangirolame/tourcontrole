class Activity < ApplicationRecord
  belongs_to :tour_store
  has_many :photos, dependent: :destroy
  has_many :bookings
  has_many :orders, through: :booking
  accepts_nested_attributes_for :photos

end

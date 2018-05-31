class Activity < ApplicationRecord
  belongs_to :tour_store
  has_many :photos, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :bookings, through: :events



  accepts_nested_attributes_for :photos
end

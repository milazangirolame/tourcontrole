class Guest < ApplicationRecord
  has_many :bookings
  has_many :events, through: :bookings
  has_many :orders, through: :bookings
  # validates :first_name, :last_name, :email, presence: true
end

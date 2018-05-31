class Guest < ApplicationRecord
  has_many :bookings
  # validates :first_name, :last_name, :email, presence: true
end

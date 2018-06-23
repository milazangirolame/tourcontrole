class Guest < ApplicationRecord
  has_many :bookings, inverse_of: :guest
  has_many :events, through: :bookings
  has_many :orders, through: :bookings
  # validates :first_name, :last_name, :email, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end

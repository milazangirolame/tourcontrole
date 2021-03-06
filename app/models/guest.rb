class Guest < ApplicationRecord
  has_many :bookings, inverse_of: :guest
  has_many :events, through: :bookings
  has_many :orders, through: :bookings
  validates :first_name, :last_name, :email, presence: true

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def api_other_id
    "#{id.to_s}-xyxy*-teste"
  end
end

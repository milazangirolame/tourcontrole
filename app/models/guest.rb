class Guest < ApplicationRecord
  belongs_to :booking_order
  validates :first_name, :last_name, :email, presence: true
end

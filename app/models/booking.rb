class Booking < ApplicationRecord
  belongs_to :event
  belongs_to :guest
  belongs_to :order
end

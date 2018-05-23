class BookingOrder < ApplicationRecord
  has_many :guests
  belongs_to :activity
  accepts_nested_attributes_for :guests

end

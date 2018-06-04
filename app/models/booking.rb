class Booking < ApplicationRecord
  belongs_to :event
  belongs_to :guest
  belongs_to :order
  accepts_nested_attributes_for :guest, reject_if: :all_blank
end

class Booking < ApplicationRecord
  belongs_to :event, optional: true
  belongs_to :guest, optional: true
  belongs_to :order
  accepts_nested_attributes_for :guest, reject_if: :all_blank
end

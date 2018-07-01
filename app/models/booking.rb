class Booking < ApplicationRecord
  validate :has_spots
  belongs_to :event
  belongs_to :guest
  belongs_to :order
  accepts_nested_attributes_for :guest, reject_if: :all_blank

  def has_spots
    if event.available_spots == 0
      errors.add(:guest,"Este evento já não tem mais vagas disponíveis")
    end
  end
end

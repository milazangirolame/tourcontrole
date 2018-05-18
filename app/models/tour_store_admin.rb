class TourStoreAdmin < ApplicationRecord
  belongs_to :user
  belongs_to :tour_store
  validates :user, :tour_store, presence: true
end

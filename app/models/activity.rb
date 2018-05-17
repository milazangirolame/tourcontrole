class Activity < ApplicationRecord
  belongs_to :tour_store
  has_many :photos, dependent: :destroy
  accepts_nested_attributes_for :photos

end

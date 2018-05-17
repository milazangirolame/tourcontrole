class Photo < ApplicationRecord
  belongs_to :activity, optional: true
  belongs_to :tour_store, optional: true
  mount_uploader :image, PhotoUploader
end

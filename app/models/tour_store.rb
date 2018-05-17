class TourStore < ApplicationRecord
  belongs_to :user
  has_many :activities, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :photos, through: :activities

  accepts_nested_attributes_for :photos
  mount_uploader :logo, PhotoUploader
  mount_uploader :image_banner, PhotoUploader

end

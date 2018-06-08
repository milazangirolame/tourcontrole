class TourStore < ApplicationRecord
  belongs_to :user
  has_many :activities, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :tour_store_admins, dependent: :destroy
  has_many :users, through: :tour_store_admins
  has_many :guests, through: :activities
  has_many :events, through: :activities
  accepts_nested_attributes_for :photos
  mount_uploader :logo, PhotoUploader
  mount_uploader :image_banner, PhotoUploader
  after_create :set_slug

  def to_param
    slug
  end

  def update_slug
    set_slug
  end

  private

  def set_slug
    self.update(slug: to_slug)
  end

end

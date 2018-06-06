class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tour_stores
  has_many :activities, through: :tour_stores
  has_many :tour_store_admins, dependent: :destroy
  mount_uploader :user_photo, PhotoUploader
  attr_accessor :terms

  def stores
    if self
      tour_store_admins.map do |tour_store_admins|
        tour_store_admins.tour_store
      end
    end
  end

end

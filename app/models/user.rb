class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tour_stores
  has_many :activities, through: :tour_stores
  mount_uploader :user_photo, PhotoUploader

end

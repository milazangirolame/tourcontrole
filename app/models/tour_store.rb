class TourStore < ApplicationRecord
  belongs_to :user
  has_one :banking_information, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :transfers
  has_many :photos, dependent: :destroy
  has_many :tour_store_admins, dependent: :destroy
  has_many :users, through: :tour_store_admins
  has_many :guests, through: :activities
  has_many :events, through: :activities
  has_many :orders, through: :activities
  accepts_nested_attributes_for :photos
  accepts_nested_attributes_for :banking_information
  mount_uploader :logo, PhotoUploader
  mount_uploader :image_banner, PhotoUploader
  after_create :set_slug
  geocoded_by :form_address
  after_validation :geocode, if: :will_save_change_to_form_address?
  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.city = geo.city
      obj.postal_code = geo.postal_code
      obj.country = geo.country
      obj.country_code = geo.country_code
      obj.state = geo.state
      obj.state_code = geo.state_code
      obj.street_number = geo.data['address_components'].select{ |d| d['types'] == ['street_number']}.first['long_name']
      obj.street_name = geo.data['address_components'].select{ |d| d['types'] == ['route']}.first['long_name']
      obj.neighborhood = geo.data['address_components'].select{ |d| d['types'].include?('sublocality')}.first['long_name']
    end
  end
  after_validation :reverse_geocode, if: :will_save_change_to_form_address?

  def to_param
    slug
  end

  def update_slug
    set_slug
  end

  def social_media_links
    get_social_media_links
  end

  def comission_percent
    5
  end

  def address
    form_address
  end

  def public_key
    moip = MoipApi.new
    moip.set_token(self) unless moip_access_token.nil?
    moip.api.keys.show.to_hash[:keys][:encryption]
  end

  def balance
    MoipApi.new(self).get_balance
  end

  def future_balance
    b = balance[:future].first
    Money.new(b[:amount],b[:currency])
  end

  def current_balance
    b = balance[:current].first
    Money.new(b[:amount],b[:currency])
  end

  def moip_orders
    MoipApi.new(self).get_orders.to_hash[:orders]
  end

  private

  def set_slug
    self.update(slug: to_slug)
  end

  def get_social_media_links
    links = {}
    links[:instagram] = instagram_link unless instagram_link.nil?
    links[:facebook] = facebook_link unless facebook_link.nil?
    links[:tripadvisor] = trip_advisor_link unless trip_advisor_link.nil?
    links[:twitter] = twitter_link unless twitter_link.nil?
    return links
  end
end

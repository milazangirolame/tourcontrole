class TourStore < ApplicationRecord
  belongs_to :user
  has_one :banking_information
  has_many :activities, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :tour_store_admins, dependent: :destroy
  has_many :users, through: :tour_store_admins
  has_many :guests, through: :activities
  has_many :events, through: :activities
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

  # campos de pagamento

  def price_range
    'Até R$ 10000,00'
  end

  def physical_products
    false
  end

  def automatic_transfer
    true
  end

  def cnpj
    regulator_id
  end

  def cpf
    regulator_id
  end

  def business_type
    description
  end

  def resp_name
    "#{user.first_name} #{user.last_name}"
  end

  def resp_cpf
    person_type == 'pj' ? legal_representant_id : business_tax_id
  end

  def telefone
    phone
  end

  def address
    form_address
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

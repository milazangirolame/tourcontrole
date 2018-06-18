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
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.city = geo.city
      obj.postal_code = geo.postal_code
      obj.country = geo.country
      obj.country_code = geo.country_code
      obj.state = geo.state
      obj.state_code = geo.state_code
    end
  end
  after_validation :reverse_geocode, if: :will_save_change_to_address?


  def to_param
    slug
  end

  def update_slug
    set_slug
  end

  def comission_percent
    5
  end

  private

  def set_slug
    self.update(slug: to_slug)
  end

  # campos de pagamento Iugu
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

end

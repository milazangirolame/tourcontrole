class Payment < ApplicationRecord
  belongs_to :order
  validates :street_number, length: {maximum: 10}
  validates :cpf, length: {is: 11}
  attr_accessor :number, :month, :year, :cvc
  def phone
    "#{phone_country_code} #{phone_area_code} #{phone_number}"
  end
end

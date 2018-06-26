class Payment < ApplicationRecord
  belongs_to :order
  attr_accessor :number, :month, :year, :cvc

  def phone
    "#{phone_country_code} #{phone_area_code} #{phone_number}"
  end
end

class Order < ApplicationRecord
  # validate :has_spots
  has_many :bookings, inverse_of: :order, dependent: :destroy
  has_many :events,through: :bookings
  has_many :guests, through: :bookings, class_name: 'Guest'
  has_many :activities, through: :events
  has_one :payment, dependent: :destroy
  accepts_nested_attributes_for :bookings, allow_destroy: true
  accepts_nested_attributes_for :guests
  accepts_nested_attributes_for :payment
  validates_associated :bookings, :guests
  attr_accessor :terms

  def total
    get_order_total
  end

  def buyer
    guests.find_by(buyer: true)
  end

  def api_other_id
    "#{id.to_s}-xy-xy*-teste"
  end

  def event
    events.first
  end

  def activity
    event.activity
  end


  def tour_store
    activity.tour_store
  end

  def spots
    guests.count
  end

  def moip_payment
    MoipApi.new(self.tour_store).get_payment(self).to_hash
  end

  def payment_status
    moip_payment[:status]
  end

  def net_payment
    a = moip_payment[:amount]
    Money.new(a[:liquid], a[:currency])
  end

  def commission
    fees[payment.installments]
  end

  def has_spots
    if spots > event.available_spots
      errors.add(:order,"Este evento já não tem mais vagas disponíveis")
    end
  end


  private

  def get_order_total
    total = Money.new(0)
    events.each do |event|
      total += event.price
    end
    return total
  end


  def fees
    {
      1 => 8,
      2 => 10,
      3 => 12,
      4 => 15,
      5 => 15,
      6 => 20,
      7 => 20,
      8 => 20,
      9 => 20,
      10 => 25,
      11 => 25,
      12 => 25
    }
   end
end

class Order < ApplicationRecord
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


  private

  def get_order_total
    total = Money.new(0)
    events.each do |event|
      total += event.price
    end
    return total
  end
end

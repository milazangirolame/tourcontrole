class Order < ApplicationRecord
  has_many :bookings, inverse_of: :order
  has_many :events,through: :bookings
  has_many :guests, through: :bookings, class_name: 'Guest'
  has_many :activities, through: :events
  has_one :payment
  accepts_nested_attributes_for :bookings, allow_destroy: true
  accepts_nested_attributes_for :guests
  accepts_nested_attributes_for :payment
  validates_associated :bookings, :guests
  attr_accessor :terms

  def total
    get_order_total
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

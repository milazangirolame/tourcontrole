class Event < ApplicationRecord
  after_create :set_times
  belongs_to :activity
  has_many :bookings, dependent: :destroy
  has_many :guests, through: :bookings

   def spots_taken
     guests.count
   end

  def available_spots
    activity.max_spots - spots_taken
  end

  def fill_rate
    Percentage.new(Rational(spots_taken, activity.max_spots)).truncate(4)
  end

  def price
    activity.price
  end

  private

  def set_times
    set_starts_at
    set_ends_at
  end

  def set_ends_at
    self.update(ends_at: starts_at + activity.duration)
  end

  def set_starts_at
    d = start_day
    t = activity.starts_at.to_time
    datetime = DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec)
    self.update(starts_at: datetime)
  end
end

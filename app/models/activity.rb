class Activity < ApplicationRecord
  serialize :recurring, Hash
  belongs_to :tour_store
  has_many :photos, dependent: :destroy
  has_many :events, dependent: :destroy, inverse_of: :activity
  has_many :bookings, through: :events
  accepts_nested_attributes_for :photos
  accepts_nested_attributes_for :photos

  def start_time
    self.starts_at
  end

  def recurring=(value)
    if !recurring.empty?
        super(RecurringSelect.dirty_hash_to_rule(value).to_hash)
    else
        super(nil)
    end
  end

  def rule
    IceCube::Rule.from_hash recurring
  end

  def schedule(start)
    schedule = IceCube::Schedule.new(start)
    schedule.add_recurrence_rule(rule)
    schedule
  end

  def calendar_events(start)
    if recurring.empty?
      [self]
    else
      starts_at = start.beginning_of_month.beginning_of_week
      ends_at = start.end_of_month.end_of_week
      schedule(starts_at).occurrences(ends_at).map do |date|
        Activity.new(id: id, name: name, starts_at: date)
      end
    end
  end

end

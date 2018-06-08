class Activity < ApplicationRecord
  serialize :recurring, Hash
  validates :starts_at, :ends_at, :max_spots, :name, presence: true
  after_create :set_start_day

  belongs_to :tour_store
  has_many :photos, dependent: :destroy
  has_many :events, dependent: :destroy, inverse_of: :activity
  has_many :bookings, through: :events
  has_many :guests, through: :events
  accepts_nested_attributes_for :photos

  def duration
    ends_at - starts_at
  end

  def start_time
    self.starts_at
  end

  def recurring=(value)
    if RecurringSelect.is_valid_rule?(value) && value != 'null'
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

  private

  def set_start_day
    self.update(start_day: starts_at.to_date)
  end

end

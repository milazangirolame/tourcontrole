class Activity < ApplicationRecord
  serialize :recurring, Hash
  belongs_to :tour_store
  has_many :photos, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :bookings, through: :events
  accepts_nested_attributes_for :photos

  def recurring=(value)
    if RecurringSelect.is_valid_rule?(value)
        super(RecurringSelect.dirty_hash_to_rule(value).to_hash)
    else
        super(nil)
    end
  end
end

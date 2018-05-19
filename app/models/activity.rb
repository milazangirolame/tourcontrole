class Activity < ApplicationRecord
  belongs_to :tour_store
  has_many :photos, dependent: :destroy
  accepts_nested_attributes_for :photos
  serialize :recurring, Hash

  def recurring=(value)
    if RecurringSelect.is_valid_rule?(value) && value != "null"
        super(RecurringSelect.dirty_hash_to_rule(value).to_hash)
    else
        super(nil)
    end
  end

end

class Transfer < ApplicationRecord
  belongs_to :tour_store
  monetize :amount_cents

  def date
    created_at.to_date.to_formatted_s(:rfc822)
  end

  def moip_status
    check_status.is_a?(Hash) ? check_status[:stauts] : 'Pending'
  end

  def check_status
    MoipApi.new(self.tour_store).get_transfer(self)
  end
end

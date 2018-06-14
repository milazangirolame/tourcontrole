class BankingInformation < ApplicationRecord
  belongs_to :tour_store
  validates :account_type, :bank_cc, :bank_ag, :bank, presence: true
end

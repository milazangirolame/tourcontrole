FactoryBot.define do
  factory :banking_information do
    bank {self.bancos.sample}
    bank_ag { Faker::Number.number(4) }
    account_type {self.account_type_options[0]}
    bank_cc { Faker::Number.number(10) }
    tour_store { build(:tour_store) }
  end
end

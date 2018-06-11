FactoryBot.define do
  factory :tour_store do
    name { "#{Faker::Company.name } #{['travel','tours', 'trips', 'adventures', 'experiences'].sample}" }
    description { Faker::Lorem.sentence(5) }
    address {Faker::Address.full_address}
    phone { Faker::PhoneNumber.phone_number }
    regulator_id { Faker::IDNumber.invalid }
    business_tax_id {Faker::IDNumber.valid }
    user {build(:user)}
  end
end

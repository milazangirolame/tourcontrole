name = %w[ hunting fishing diving sky-diving biking skiing riding]

FactoryBot.define do
  factory :activity do
    name { name.sample }
    description { Faker::Lorem.sentence(5) }
    starts_at { DateTime.now}
    ends_at {self.starts_at + rand(2..6)}
    max_spots {rand(12..26)}
    price {rand(119..459)}
    tour_store { create(:tour_store)}
    departure_location { self.tour_store.address}
    recurring { '{:validations=>{:day=>[2, 3, 5]}, :rule_type=>"IceCube::WeeklyRule", :interval=>1, :week_start=>0}'}
  end
end



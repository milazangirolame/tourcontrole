require 'ice_cube'
TourStore.destroy_all
Guest.destroy_all
Order.destroy_all

if User.find_by(email: 'oscar@teste.com').nil?
  oscar_teste = User.new(email:'oscar@teste.com', password:'123123',first_name:'Oscar', last_name:'Teste')
  oscar_teste.save
else
  oscar_teste = User.find_by(email: 'oscar@teste.com')
end

if User.find_by(email: 'ortizg.oscar@gmail.com').nil?
  oscar = User.new(email:'ortizg.oscar@gmail.com', password:'123123',first_name:'Oscar', last_name:'Ortiz')
  oscar.save
else
  oscar = User.find_by(email: 'ortizg.oscar@gmail.com')
end

if User.find_by(email: 'user@user.com').nil?
  user = User.new(email:'user@user.com', password:'123123',first_name:'User', last_name:'User')
  user.save
else
  user = User.find_by(email: 'user@user.com')
end

store_1 = TourStore.new(
  name:'Exploratour do Oscar',
  website:'url-oscar-teste.com',
  description: 'Os melhores tours do Oscar Teste',
  address: Faker::Address.full_address,
  user: oscar_teste,
  dummy: true
  )
user_store1 = TourStoreAdmin.new(user: store_1.user, tour_store: store_1)
user_store1.save

store_1.save


store_2 = TourStore.new(
  name:'Excursões aventureiras',
  website:'url-user-user.com',
  description: 'Os melhores tours do User User',
  address: Faker::Address.full_address,
  user: user,
  dummy: true
  )
store_2.save

user_store2 = TourStoreAdmin.new(user: store_2.user,tour_store: store_2)
user_store2.save

counter = 0
3.times do
  counter += 1
  act = Activity.new(
    name:"Tour #{counter} da: #{store_1.name}",
    description: "muito bom tour \n #{Faker::Lorem.paragraph(2)}",
    max_spots: rand(11..23),
    tour_store: store_1,
    starts_at: Time.now,
    ends_at: Time.now + 2,
    price: rand(180..450),
    recurring: {:validations=>{:day=>[1, 2, 4]},
                 :rule_type=>"IceCube::WeeklyRule",
                 :interval=>1,
                 :week_start=>0
               },

    )
    act.departure_location = act.tour_store.address
  act.save
end

counter = 0
3.times do
  counter += 1
  act = Activity.new(
    name:"Tour #{counter} da: #{store_2.name}",
    description: "muito bom tour \n #{Faker::Lorem.paragraph(2)}",
    max_spots: rand(11..23),
    tour_store: store_2,
    starts_at: Time.now,
    ends_at: Time.now + 1,
    price: rand(180..450),
    recurring: {:validations=>{:day=>[2, 3, 5]},
                 :rule_type=>"IceCube::WeeklyRule",
                 :interval=>1,
                 :week_start=>0
               },
    )
    act.departure_location = act.tour_store.address
  act.save
end

puts 'All done'

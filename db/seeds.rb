require 'ice_cube'
puts 'Setting users'

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

puts 'making stores'

ocean = TourStore.new(
  name:'Ocean Dive center',
  website:'www.ocean-divers.com',
  description: 'Os melhores passeios de mergulho',
  form_address: 'Rua dos Pinheiros - Pinheiros, São Paulo - State of São Paulo, Brazil',
  user: oscar_teste,
  dummy: true,
  business_tax_id: '23468577850',
  legal_representant_id: '23468577850',
  phone: '942675876'
  )
ocean.save
MoipApi.new().create_store(ocean)

ocean_manager = TourStoreAdmin.new(user: ocean.user, tour_store: ocean, manager: true)
ocean_manager.save


explorer = TourStore.new(
  name:'Explorer tours',
  website:'www.explorer-tours.com',
  description: 'As melhores excursões de adventuras',
  form_address: 'Rua Maranhão 152 - Higienópolis, São Paulo - State of São Paulo',
  user: oscar_teste,
  dummy: true,
  business_tax_id: '23468577850',
  legal_representant_id: '23468577850',
  phone: '942675876'
  )

explorer.save
MoipApi.new().create_store(explorer)


explorer_manager = TourStoreAdmin.new(user: explorer.user,tour_store: explorer, manager: true)
explorer_manager.save

counter = 0
3.times do
  counter += 1
  act = Activity.new(
    name:"Tour #{counter} da: #{ocean.name}",
    description: "Mergulho de boa \n #{Faker::Lorem.paragraph(2)}",
    max_spots: rand(11..23),
    tour_store: ocean,
    starts_at: Time.now,
    ends_at: Time.now + 2,
    price: rand(1180..4450),
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
    name:"Tour #{counter} da: #{explorer.name}",
    description: "Explorer tour \n #{Faker::Lorem.paragraph(2)}",
    max_spots: rand(11..23),
    tour_store: explorer,
    starts_at: Time.now,
    ends_at: Time.now + 1,
    price: rand(1180..4450),
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

TourStore.destroy_all
TourStoreAdmin.destroy_all

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
  name:'Tienda de "oscar teste"',
  website:'url-oscar-teste.com',
  description: 'Os melhores tours do Oscar Teste',
  user: oscar_teste
  )
user_store1 = TourStoreAdmin.new(user: store_1.user, tour_store: store_1)
user_store1.save

store_1.save


store_2 = TourStore.new(
  name:'Tienda de "User User"',
  website:'url-user-user.com',
  description: 'Os melhores tours do USer User',
  user: user
  )
store_2.save

user_store2 = TourStoreAdmin.new(user: store_2.user,tour_store: store_2)
user_store2.save

counter = 0
3.times do
  counter += 1
  act = Activity.new(
    name:"Tour #{counter} da: #{store_1.name}",
    description: 'muito bom tour',
    max_spots: rand(11.23),
    tour_store: store_1
    )
  act.save
end

counter = 0
3.times do
  counter += 1
  act = Activity.new(
    name:"Tour #{counter} da: #{store_2.name}",
    description: 'muito bom tour',
    max_spots: rand(11.23),
    tour_store: store_2
    )
  act.save
end

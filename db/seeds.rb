puts 'Setting test users'
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

puts 'Test users setted'

puts 'Updating slugs'

TourStore.all.each { |store| store.update_slug }
Activity.all.each { |act| act.update_slug }

puts 'Tasks completed'
puts 'All done'

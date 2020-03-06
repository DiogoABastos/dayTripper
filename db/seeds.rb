# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'deleting every fcking thing 🧨'
Review.delete_all
Location.destroy_all
Itinerary.destroy_all
User.delete_all


puts 'creating two users'
m = User.create!({ email: 'm@gmail.com', password: 123456, username: 'jgarcia' })
s = User.create!({ email: 's@gmail.com', password: 123456, username: 'stevespiders' })
d = User.create!({ email: 'd@gmail.com', password: 123456, username: 'megabebe' })
g = User.create!({ email: 'g@gmail.com', password: 123456, username: 'gz3000' })

puts 'creating 6 locations'
s_jorge = Location.create!({ name: 'São Jorge', address: 'Largo de Santa Cruz do Castelo, Santa Maria Maior, Área Metropolitana de Lisboa, Portugal', description: 'Very nice castle and view over the city', category: 'Castle', duration: 150 })
m_moniz = Location.create!({ name: 'Martim Moniz', address: 'Martim Moniz', description: 'Cultural extravaganza', category: 'Plaza', duration: 30 })
f_ladra = Location.create!({ name: 'Feira da ladra', address: 'Feira da ladra', description: 'Awsome market with stolen goods. You can also sell your own.', category: 'Market', duration: 60 })

boca_inferno = Location.create!({ name: 'Boca do Inferno', address: 'Boca do Inferno', description: 'View over the ridges to the depths of hell', category: 'Landscape', duration: 60 })
guincho = Location.create!({ name: 'Praia do Guincho', address: 'Praia do Guincho', description: 'Very long beach full of sexy people', category: 'Beach', duration: 300 })
marina_cascais = Location.create!({ name: 'Marina de Cascais', address: 'Marina de Cascais', description: 'A spot with places to eat with a nice view to the ocean. Great to have a beer and chill.', category: 'Marina', duration: 120 })

puts 'creating a bunch of itineraries'
abana = Itinerary.new({ name: 'Lisbon center', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = s
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!

beach = Itinerary.new({ name: 'Beach trip cascais', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = m
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!




abana = Itinerary.new({ name: 'Lisbon views', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = d
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!

beach = Itinerary.new({ name: 'Awsome Beaches', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = g
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!


abana = Itinerary.new({ name: 'Lisbon rocks', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = m
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!

beach = Itinerary.new({ name: 'Beaches forever', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = s
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!


abana = Itinerary.new({ name: 'Views and screws', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = d
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!

beach = Itinerary.new({ name: 'Juggling beaches', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = g
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!

abana = Itinerary.new({ name: 'City stuff', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = m
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!

beach = Itinerary.new({ name: 'Paradise beach', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = s
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!

abana = Itinerary.new({ name: 'Cultural interchange', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = d
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!

beach = Itinerary.new({ name: 'Beach bomb', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = g
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!

abana = Itinerary.new({ name: 'Mind explosion', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = m
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!

beach = Itinerary.new({ name: 'Sand trails', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = s
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!

abana = Itinerary.new({ name: 'Cultural boom', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = d
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!

beach = Itinerary.new({ name: 'Sand box', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = g
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!


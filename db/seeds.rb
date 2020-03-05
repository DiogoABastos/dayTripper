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
a = User.create!({ email: 'a@gmail.com', password: 123456, username: 'megabebe' })
b = User.create!({ email: 'b@gmail.com', password: 123456, username: 'megagigante' })

puts 'creating 6 locations'
s_jorge = Location.create!({ name: 'São Jorge', address: 'Largo de Santa Cruz do Castelo, Santa Maria Maior, Área Metropolitana de Lisboa, Portugal', description: 'cool beans', category: 'Castle', duration: 150 })
m_moniz = Location.create!({ name: 'Martim Moniz', address: 'Martim Moniz', description: 'very cool beans', category: 'Plaza', duration: 30 })
f_ladra = Location.create!({ name: 'Feira da ladra', address: 'Feira da ladra', description: 'cool very beans', category: 'Market', duration: 60 })

boca_inferno = Location.create!({ name: 'Boca do Inferno', address: 'Boca do Inferno', description: 'very cool very beans', category: 'Landscape', duration: 60 })
guincho = Location.create!({ name: 'Praia do Guincho', address: 'Praia do Guincho', description: 'very very cool very beans', category: 'Beach', duration: 300 })
marina_cascais = Location.create!({ name: 'Marina de Cascais', address: 'Marina de Cascais', description: 'cool very beans very', category: 'Marina', duration: 120 })

puts 'creating a bunch of itineraries'
abana = Itinerary.new({ name: 'Abana o bum-bum', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = a
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!

beach = Itinerary.new({ name: 'boom boom beach', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = b
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!




abana = Itinerary.new({ name: 'Some some something', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = a
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!

beach = Itinerary.new({ name: 'some itinerary', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = b
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!


abana = Itinerary.new({ name: 'some itinerary 1', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = a
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!

beach = Itinerary.new({ name: 'some itinerary 2', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = b
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!


abana = Itinerary.new({ name: 'some itinerary 3', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = a
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!

beach = Itinerary.new({ name: 'some itinerary 4', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = b
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!

abana = Itinerary.new({ name: 'some itinerary 5', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = a
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!

beach = Itinerary.new({ name: 'some itinerary 6', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = b
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!

abana = Itinerary.new({ name: 'some itinerary 7', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = a
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!

beach = Itinerary.new({ name: 'some itinerary 8', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = b
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!

abana = Itinerary.new({ name: 'some itinerary 9', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = a
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!

beach = Itinerary.new({ name: 'some itinerary 10', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = b
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!

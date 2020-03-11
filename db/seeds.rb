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
ItineraryLocation.destroy_all
User.delete_all


puts 'creating two users'
m = User.create!({ email: 'm@gmail.com', password: 123456, username: 'jgarcia' })
s = User.create!({ email: 's@gmail.com', password: 123456, username: 'stevespiders' })
d = User.create!({ email: 'd@gmail.com', password: 123456, username: 'megabebe' })
g = User.create!({ email: 'g@gmail.com', password: 123456, username: 'gz3000' })

puts 'creating 6 locations'
s_jorge = Location.new({ name: 'São Jorge', address: 'Largo de Santa Cruz do Castelo, Santa Maria Maior, Área Metropolitana de Lisboa, Portugal', description: 'Very nice castle and view over the city', duration: 150 })
s_jorge.tag_list.add("Castle")
s_jorge.save!

m_moniz = Location.new({ name: 'Martim Moniz', address: 'Martim Moniz', description: 'Cultural extravaganza', duration: 30 })
m_moniz.tag_list.add("Cultural")
m_moniz.save!

f_ladra = Location.new({ name: 'Feira da ladra', address: 'Feira da ladra', description: 'Awsome market with stolen goods. You can also sell your own.', duration: 60 })
f_ladra.tag_list.add("Market")
f_ladra.save!


boca_inferno = Location.new({ name: 'Boca do Inferno', address: 'Boca do Inferno', description: 'View over the ridges to the depths of hell', duration: 60 })
boca_inferno.tag_list.add("Nature")
boca_inferno.save!

guincho = Location.new({ name: 'Praia do Guincho', address: 'Praia do Guincho', description: 'Very long beach full of sexy people', duration: 300 })
guincho.tag_list.add("Beach")
guincho.save!

marina_cascais = Location.new({ name: 'Marina de Cascais', address: 'Marina de Cascais', description: 'A spot with places to eat with a nice view to the ocean. Great to have a beer and chill.', duration: 120 })
marina_cascais.tag_list.add("Marina")
marina_cascais.save!


puts 'creating a bunch of itineraries'
abana = Itinerary.new({ name: 'Lisbon center', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = s
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!
abana.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

beach = Itinerary.new({ name: 'Beach trip Cascais', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = m
beach.locations << [boca_inferno, guincho, marina_cascais]
guincho_photo = URI.open("https://www.golisbon.com/images/images/guincho-beach.jpg")
beach.photo.attach(io: guincho_photo, filename: 'guincho.jpg', content_type: 'image/jpg')
beach.save!
beach.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

abana = Itinerary.new({ name: 'Lisbon views', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = d
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!
abana.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

beach = Itinerary.new({ name: 'Awsome Beaches', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = g
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!
beach.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

abana = Itinerary.new({ name: 'Lisbon rocks', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = m
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!
abana.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

beach = Itinerary.new({ name: 'Beaches forever', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = s
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!
beach.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

abana = Itinerary.new({ name: 'Views and screws', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = d
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!
abana.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

beach = Itinerary.new({ name: 'Juggling beaches', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = g
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!
beach.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

abana = Itinerary.new({ name: 'City stuff', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = m
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!
abana.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

beach = Itinerary.new({ name: 'Paradise beach', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = s
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!
beach.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

abana = Itinerary.new({ name: 'Cultural interchange', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = d
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!
abana.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

beach = Itinerary.new({ name: 'Beach bomb', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = g
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!
beach.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

abana = Itinerary.new({ name: 'Mind explosion', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = m
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!
abana.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

beach = Itinerary.new({ name: 'Sand trails', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = s
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!
beach.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

abana = Itinerary.new({ name: 'Cultural boom', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = d
abana.locations << [s_jorge, m_moniz, f_ladra]
abana.save!
abana.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

beach = Itinerary.new({ name: 'Sand box', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = g
beach.locations << [boca_inferno, guincho, marina_cascais]
beach.save!
beach.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end


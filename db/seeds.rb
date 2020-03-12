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

# praca_rossio = Location.new({ name: 'Praca Rossio', address: 'Praca Rossio', description: 'A place in the heart of Lisbon with nice restaurants and cultural attractions', duration: 60 })
# praca_rossio.tag_list.add("Cultural")
# praca_rossio.save!

# topo_bar_chiado = Location.new({ name: 'Topo Bar Chiado', address: 'Topo Bar Chiado', description: 'A nice panoramic restaurant in the heart of Lisbon with nice tapas and  wine list', duration: 60 })
# topo_bar_chiado.tag_list.add("Cultural")
# topo_bar_chiado.save!

# rua_agusta = Location.new({ name: 'Rua Agusta', address: 'Rua Agusta', description: 'A beautiful street that ends up with Praca do Comercio', duration: 15 })
# rua_agusta.tag_list.add("Cultural")
# rua_agusta.save!

# praca_do_comercio = Location.new({ name: 'Praça do Comércio', address: 'Praça do Comércio', description: 'The huge square in the heart of Lisbon near the Tagus river. Nice for enjoying sunsets.', duration: 25 })
# praca_do_comercio.tag_list.add("Cultural")
# praca_do_comercio.save!

# se_de_lisboa = Location.new({ name: 'Sé de Lisboa', address: 'Sé de Lisboa', description: 'The oldest church in Lisbon', duration: 20 })
# se_de_lisboa.tag_list.add("Cultural")
# se_de_lisboa.save!

# portas_do_sol = Location.new({ name: 'Portas do Sol', address: 'Portas do Sol', description: 'The restaurant where you can enjoy food and drinks with a view overlooking Alfama rooftops', duration: 60 })
# portas_do_sol.tag_list.add("Cultural")
# portas_do_sol.save!


puts 'creating a bunch of itineraries'


beach = Itinerary.new({ name: 'Beach trip Cascais', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 660 })
beach.user = m
beach.locations << [boca_inferno, guincho, marina_cascais]
boca_inferno_photo = URI.open("https://upload.wikimedia.org/wikipedia/commons/6/63/Boca_do_Inferno_em_Cascais.jpg")
guincho_photo = URI.open("https://www.golisbon.com/images/images/guincho-beach.jpg")
marina_cascais_photo = URI.open("https://www.messagez.com/wp-content/gallery/lisbon/beautiful-cascais-marina-at-sunset-photography-2-by-messagez-com_.jpg")
beach.photo.attach(io: boca_inferno_photo, filename: 'boca_inferno.jpg', content_type: 'image/jpg')
beach.photo.attach(io: guincho_photo, filename: 'guincho.jpg', content_type: 'image/jpg')
beach.photo.attach(io: marina_cascais_photo, filename: 'marina_cascais.jpg', content_type: 'image/jpg')
beach.save!
beach.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

abana = Itinerary.new({ name: 'Lisbon views', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = d
abana.locations << [s_jorge, m_moniz, f_ladra]
abana_photo = URI.open("https://jetsettingfools.com/wp-content/uploads/2014/12/Arco-da-Rua-Augusta-Lisbon-Portugal.jpg")
abana.photo.attach(io: abana_photo, filename: 'abana.jpg', content_type: 'image/jpg')
abana.save!
abana.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

beach = Itinerary.new({ name: 'Awesome Beaches', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = g
beach.locations << [boca_inferno, guincho, marina_cascais]
beach_photo = URI.open("https://www.travel-in-portugal.com/sites/default/files/beaches/praia-da-abano-cascais.jpg")
beach.photo.attach(io: beach_photo, filename: 'beach.jpg', content_type: 'image/jpg')
beach.save!
beach.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

abana = Itinerary.new({ name: 'Lisbon rocks', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = m
abana.locations << [s_jorge, m_moniz, f_ladra]
abana_photo = URI.open("https://ipt.imgix.net/202224/x/0/9-day-portugal-photography-tour-algarve-beaches-amp-lisbon.jpg?auto=format%2Ccompress&fit=crop&crop=faces%2Ccenter&ixlib=react-8.6.4&h=360&w=920")
abana.photo.attach(io: abana_photo, filename: 'abana.jpg', content_type: 'image/jpg')
abana.save!
abana.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

beach = Itinerary.new({ name: 'Beaches forever', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = s
beach.locations << [boca_inferno, guincho, marina_cascais]
beach_photo = URI.open("https://algarvevillasblog.files.wordpress.com/2017/07/020-stranden-costa-vicentina-05-arrifana.jpg")
beach.photo.attach(io: beach_photo, filename: 'beach.jpg', content_type: 'image/jpg')
beach.save!
beach.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

abana = Itinerary.new({ name: 'Oldest buildings in Lisbon tour', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = d
abana.locations << [s_jorge, m_moniz, f_ladra]
abana_photo = URI.open("https://i.insider.com/5d23720921a861344a2957ff?width=1100&format=jpeg&auto=webp")
abana.photo.attach(io: abana_photo, filename: 'abana.jpg', content_type: 'image/jpg')
abana.save!
abana.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

beach = Itinerary.new({ name: 'Secret beaches outside Lisbon', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = g
beach.locations << [boca_inferno, guincho, marina_cascais]
beach_photo = URI.open("https://prideofmauicom.b-cdn.net/blog/wp-content/uploads/2014/03/Mauis-Top-10-Off-the-Beaten-Path_Paako-header.jpg")
beach.photo.attach(io: beach_photo, filename: 'beach.jpg', content_type: 'image/jpg')
beach.save!
beach.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

abana = Itinerary.new({ name: 'Trams, markets and history', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = m
abana.locations << [s_jorge, m_moniz, f_ladra]
abana_photo = URI.open("https://images4.newscred.com/Zz0xZmQwYzliMTU1YzkzNTM5ZTZmN2Q0NWQ3ZWFlMDFiMw==?height=480&width=800")
abana.photo.attach(io: abana_photo, filename: 'abana.jpg', content_type: 'image/jpg')
abana.save!
abana.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

beach = Itinerary.new({ name: 'Beach hikes with locals', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = s
beach.locations << [boca_inferno, guincho, marina_cascais]
beach_photo = URI.open("https://live.staticflickr.com/7138/7002505010_14d49b1070_b.jpg")
beach.photo.attach(io: beach_photo, filename: 'beach.jpg', content_type: 'image/jpg')
beach.save!
beach.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

abana = Itinerary.new({ name: 'Cultural interchange', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = d
abana.locations << [s_jorge, m_moniz, f_ladra]
abana_photo = URI.open("https://k6u8v6y8.stackpathcdn.com/blog/wp-content/uploads/2013/12/top-places-for-a-delightful-cultural-trip-in-india.png")
abana.photo.attach(io: abana_photo, filename: 'abana.jpg', content_type: 'image/jpg')
abana.save!
abana.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

beach = Itinerary.new({ name: 'Hidden beach near city center', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = g
beach.locations << [boca_inferno, guincho, marina_cascais]
beach_photo = URI.open("https://live.staticflickr.com/65535/48470338191_dd40b6bcbf_b.jpg")
beach.photo.attach(io: beach_photo, filename: 'beach.jpg', content_type: 'image/jpg')
beach.save!
beach.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

abana = Itinerary.new({ name: 'Sunrise to sunset Lisbon living', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = m
abana.locations << [s_jorge, m_moniz, f_ladra]
abana_photo = URI.open("https://www.lisbonlux.com/images/lisbon/praca-martim-moniz.jpg")
abana.photo.attach(io: abana_photo, filename: 'abana.jpg', content_type: 'image/jpg')
abana.save!
abana.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

beach = Itinerary.new({ name: 'Sand trails', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = s
beach.locations << [boca_inferno, guincho, marina_cascais]
beach_photo = URI.open("https://thumbor.forbes.com/thumbor/711x424/https://specials-images.forbesimg.com/dam/imageserve/685825834/960x0.jpg?fit=scale")
beach.photo.attach(io: beach_photo, filename: 'beach.jpg', content_type: 'image/jpg')
beach.save!
beach.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

abana = Itinerary.new({ name: 'Local cuisine fiesta', description: "Really nice views with a foreign aroma of spices", duration: 300 })
abana.user = d
abana.locations << [s_jorge, m_moniz, f_ladra]
abana_photo = URI.open("https://d4qwptktddc5f.cloudfront.net/easy_thumbnails/thumbs_Interior-Design-American-Kennel-Club-Museum-of-the-Dog-New-York-01-0319.jpg.770x0_q95.jpg")
abana.photo.attach(io: abana_photo, filename: 'abana.jpg', content_type: 'image/jpg')
abana.save!
abana.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

beach = Itinerary.new({ name: 'Salty hair, sandy toes', description: "Beach landscpaes and whatnot and good to shake them booties", duration: 570 })
beach.user = g
beach.locations << [boca_inferno, guincho, marina_cascais]
beach_photo = URI.open("https://www.visitportugal.com/sites/default/files/styles/encontre_detalhe_poi_destaque/public/mediateca/LIS_Cascais-Cresmina-Guincho_660x371.jpg?itok=xEwKPAvg")
beach.photo.attach(io: beach_photo, filename: 'beach.jpg', content_type: 'image/jpg')
beach.save!
beach.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

# ----------------------------------------   THE MAIN SEED   --------------------------------------------------

puts "creating the special locations"

georges_pub = Location.new({ name: 'Georges Pub', address: 'Bairro Alto, Misericórdia, Área Metropolitana de Lisboa, Portugal', description: 'Epic British Pub in Lisbon. Heavy drinking with your mates!', duration: 120 })
georges_pub.tag_list.add("Drinks")
georges_pub.save!

praca_rossio = Location.new({ name: 'Rossio', address: 'Praça Martim Moniz, Santa Maria Maior, Área Metropolitana de Lisboa, Portugal', description: 'The square features a large pedestrian area flanked by trees with numerous cafes, restaurants and touristy shops', duration: 60 })
praca_rossio.tag_list.add("Plaza", "Landmark")
praca_rossio.save!

topo_bar_chiado = Location.new({ name: 'Topo Bar Chiado', address: 'Chiado, Santa Maria Maior, Área Metropolitana de Lisboa, Portugal', description: 'TOPO Chiado rooftop bar restaurant Lisbon: panoramic city views, Carmo church ruins & lounging', duration: 60 })
topo_bar_chiado.tag_list.add("Rooftop Bar", "Drinks")
topo_bar_chiado.save!

rua_agusta = Location.new({ name: 'Rua Agusta', address: 'Rua Augusta, Santa Maria Maior, Área Metropolitana de Lisboa, Portugal', description: 'One of the most beautiful main streets that leads up to Praca do Comercio', duration: 10 })
rua_agusta.tag_list.add("Main Street", "Cultural")
rua_agusta.save!

praca_do_comercio = Location.new({ name: 'Praça do Comércio', address: 'Praça do Comércio, Santa Maria Maior, Área Metropolitana de Lisboa, Portugal', description: "Lisbon's most important square: the Praça do Comércio was for decades Lisbon's main entrepôt, and crucial for its maritime trade.", duration: 10 })
praca_do_comercio.tag_list.add("Plaza", "Walk")
praca_do_comercio.save!

se_de_lisboa = Location.new({ name: 'Sé de Lisboa', address: 'Largo da Sé, Santa Maria Maior, Área Metropolitana de Lisboa, Portugal', description: 'he Lisbon Cathedral often called simply the Sé, is a Roman Catholic cathedral located in Lisbon, Portugal. The oldest church in the city is the seat of the', duration: 20 })
se_de_lisboa.tag_list.add("Church", "Historic")
se_de_lisboa.save!

portas_do_sol = Location.new({ name: 'Portas do Sol', address: 'Portas do Sol, Santa Maria Maior, Área Metropolitana de Lisboa, Portugal', description: 'ONE OF THE BEST VIEWS ON LISBON. –. Portas do Sol is a terrace coffee and cocktail bar, designed to take advantage of its exceptional location.', duration: 60 })
portas_do_sol.tag_list.add("Viewpoint", "Drinks")
portas_do_sol.save!

georges_pub_photo = URI.open("https://portugalconfidential.com/wp-content/uploads/2015/02/The-George-Pub-Lisbon-feature.jpg")
praca_rossio_photo = URI.open("https://c2.quickcachr.fotos.sapo.pt/i/G67070ca1/9435270_iZwkU.jpeg")
topo_bar_chiado_photo = URI.open("https://cdn5.sabado.pt/images/2016-07/img_797x448$2016_07_26_21_31_57_179326.jpg")
rua_agusta_photo = URI.open("https://ak7.picdn.net/shutterstock/videos/7319767/thumb/1.jpg")
praca_do_comercio_photo = URI.open("https://media-manager.noticiasaominuto.com/1920/1541841849/naom_535e36fe684c1.jpg")
se_de_lisboa_photo = URI.open("https://live.staticflickr.com/7211/13404726415_e869143df2_b.jpg")
portas_do_sol_photo = URI.open("https://www.lisbonlux.com/images/lisbon/portas-do-sol-terrace.jpg")

georges_pub.photos.attach(io: georges_pub_photo, filename: 'georges_pub.jpg', content_type: 'image/jpg')
praca_rossio.photos.attach(io: praca_rossio_photo, filename: 'praca_rossio.jpg', content_type: 'image/jpg')
topo_bar_chiado.photos.attach(io: topo_bar_chiado_photo, filename: 'topo_bar_chiado.jpg', content_type: 'image/jpg')
rua_agusta.photos.attach(io: rua_agusta_photo, filename: 'rua_agusta.jpg', content_type: 'image/jpg')
praca_do_comercio.photos.attach(io: praca_do_comercio_photo, filename: 'praca_do_comercio.jpg', content_type: 'image/jpg')
se_de_lisboa.photos.attach(io: se_de_lisboa_photo, filename: 'se_de_lisboa.jpg', content_type: 'image/jpg')
portas_do_sol.photos.attach(io: portas_do_sol_photo, filename: 'portas_do_sol.jpg', content_type: 'image/jpg')

puts 'creating THE Itinerary'
lisbon_walk = Itinerary.new({ name: 'Top Lisbon sites & Drinks :)', description: "The Best of Lisbon: Historical Views & Drink Stops", duration: 300 })
lisbon_walk.user = g
lisbon_walk.locations << [georges_pub, portas_do_sol, praca_rossio, topo_bar_chiado, rua_agusta, praca_do_comercio, se_de_lisboa]
lisbon_walk_photo = URI.open("https://www.visitportugal.com/sites/default/files/styles/encontre_detalhe_poi_destaque/public/mediateca/N4.OTR1435D.jpg?itok=SCYgpQYi")
lisbon_walk.photo.attach(io: lisbon_walk_photo, filename: 'lisbon_walk.jpg', content_type: 'image/jpg')
lisbon_walk.save!
lisbon_walk.itinerary_locations.each_with_index do |elem, ix|
  elem.update(drag_order: ix)
end

puts "All done"

z = "Best spots ever, I had a great time!"
x = "A great option to spend any day"
c = "Awsome!!!"
h = "Loved the drinking!"
b = "I had an awsome cultural experience"
v = "Cant wait to go on it again."
h = "One word.. A-M-A-Z-I-N-G"

Itinerary.all.each do |it|
  rand(2..4).times do
    new_review = Review.new(
      description: [z, x, c, h, b, v, m].sample,
      rating: rand(3..5)
    )
    new_review.user = ([s, m, d, g] - [it.user]).sample
    new_review.itinerary = it
    new_review.save!
  end
end

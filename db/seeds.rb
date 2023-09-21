# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or create!d alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "json"

# Purge database
Plant.destroy_all
User.destroy_all
Garden.destroy_all
GardenPlant.destroy_all

puts "adding users test@test.fr"

user = User.create!(email: "test@test.fr", password: "123456", phone_number: "+33656773726", role: User.roles[:user])
puts "user Test added with password 123456"

vip = User.create!(email: "vip@test.fr", password: "123456", phone_number: "+33683073726", role: User.roles[:vip])
puts "vip Test added with password 123456"

admin = User.create!(email: "admin@test.fr", password: "123456", phone_number: "+33693073726", role: User.roles[:admin])
puts "admin Test added with password 123456"

puts "Adding plants"
counter = 1

# Garden.create(user_id: user.id, name: "Balcon de cuisine", light: 0 , size:0 , care_willing: 0, location: "Paris,France")

# puts "Adding plants number 1"
# plant = Plant.create(name: "Heuchère",
#   color: "Rouge",
#   caducity: "Persistant",
#   care_frequency: 1,
#   water_need: 0,
#   growth_speed: 0,
#   cold_resistance: 0,
#   light_need: 1,
#   climate: [
#     "Climat océanique",
#     "Climat semi-océanique",
#     "Climat continental",
#     "Climat montagnard",
#     "Climat méditerranéen"
#   ],
#   content: "L’heuchère est une plante vivace de la famille des Saxifragacées, originaire d’Amérique du Nord avec 50 espèces et aujourd’hui plus de 500 variétés horticoles cultivées." ,
#   final_size: 0)
#   if plant.photo.attached?
#     plant.photo.purge
#   end
#   file = File.open("./app/assets/images/plantes/heuchère.jpg")
#   # puts file
#   plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
#   # GardenPlant.create(nickname: "Heuss", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)

# ###################################################################
# ###################################################################

#   puts "Adding plants number 2"
# plant = Plant.create(name: "Ciboulette",
#   color: "Green",
#   caducity: "Persistant",
#   care_frequency: 1,
#   water_need: 1,
#   growth_speed: 0,
#   cold_resistance: 0,
#   light_need: 1,
#   climate: [
#     "Climat océanique",
#     "Climat semi-océanique",
#     "Climat continental",
#     "Climat montagnard",
#     "Climat méditerranéen"
#   ],
#   content: "La ciboulette, superbe plante aromatique, se plaît dans le potager, jardin, terrasse et balcon. C'est une herbe indispensable pour relever nos plats cuisinés. Très facile à cultiver, elle possède, en outre, des vertus apéritives et digestives." ,
#   final_size: 0)
#   if plant.photo.attached?
#     plant.photo.purge
#   end
#   file = File.open("./app/assets/images/plantes/ciboulette.jpg")
#   # puts file
#   plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
#   # GardenPlant.create(nickname: "Ciboul", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)

# ###################################################################
# ###################################################################

# puts "Adding plants number 3"
# plant = Plant.create(name: "Dionée",
#                       color: "White",
#                       caducity: "Persistant",
#                       care_frequency: 1,
#                       water_need: 1,
#                       growth_speed: 1,
#                       cold_resistance: 2,
#                       light_need: 1,
#                       climate: [
#                         "Climat océanique",
#                         "Climat semi-océanique",
#                         "Climat continental",
#                         "Climat montagnard",
#                         "Climat méditerranéen"
#                       ],
#                       content: "La dionée (Dionaea) est la plus célèbre des plantes carnivores. Fascinante par ses pièges complexes et efficaces, elle se porte bien en culture extérieure si on la protège en hiver. Elle a besoin de soins attentifs, mais n'est pas d'une culture difficile." ,
#                       final_size: 0)
# if plant.photo.attached?
#   plant.photo.purge
# end
# file = File.open("./app/assets/images/plantes/dionée.jpg")
# # puts file
# plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
# # GardenPlant.create(nickname: "Dieudonnée", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)

# ###################################################################
# ###################################################################

# puts "Adding plants number 4"
# plant = Plant.create(name: "Fougère",
#                       color: "Green",
#                       caducity: "Persistant",
#                       care_frequency: 1,
#                       water_need: 1,
#                       growth_speed: 1,
#                       cold_resistance: 2,
#                       light_need: 1,
#                       climate: [
#                         "Climat océanique",
#                         "Climat semi-océanique",
#                         "Climat continental",
#                         "Climat montagnard",
#                         "Climat méditerranéen"
#                       ],
#                       content: "Utilisé comme fougère d’intérieur depuis le XIXe siècle, le nephrolepis offre des frondes opulentes d’aspect décoratif. Il fait partie des plantes vertes basiques et résistantes facilement cultivables, même par ceux qui n’ont pas la main verte." ,
#                       final_size: 0)
# if plant.photo.attached?
#   plant.photo.purge
# end
# file = File.open("./app/assets/images/plantes/fougère.jpg")
# # puts file
# plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
# # GardenPlant.create(nickname: "Fouggiare", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)

# ###################################################################
# ###################################################################

# puts "Adding plants number 5"
# plant = Plant.create(name: "Lavande",
#                       color: "Purple",
#                       caducity: "Persistant",
#                       care_frequency: 1,
#                       water_need: 2,
#                       growth_speed: 1,
#                       cold_resistance: 2,
#                       light_need: 1,
#                       climate: [
#                         "Climat océanique",
#                         "Climat semi-océanique",
#                         "Climat continental",
#                         "Climat montagnard",
#                         "Climat méditerranéen"
#                       ],
#                       content: "La lavande est un élégant arbrisseau qui symbolise la Provence et le soleil. Ses rameaux simples, touffus et dressés sont pourvus de feuilles vert cendré. Ses fleurs aux teintes pastel dégagent un parfum suave et pénétrant." ,
#                       final_size: 0)
# if plant.photo.attached?
#   plant.photo.purge
# end
# file = File.open("./app/assets/images/plantes/lavande.jpg")
# # puts file
# plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
# # GardenPlant.create(nickname: "Lavande", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)

# ###################################################################
# ###################################################################

# puts "Adding plants number 6"
# plant = Plant.create(name: "Basilic",
#                       color: "Green",
#                       caducity: "Persistant",
#                       care_frequency: 1,
#                       water_need: 2,
#                       growth_speed: 1,
#                       cold_resistance: 2,
#                       light_need: 1,
#                       climate: [
#                         "Climat océanique",
#                         "Climat semi-océanique",
#                         "Climat continental",
#                         "Climat montagnard",
#                         "Climat méditerranéen"
#                       ],
#                       content: "Le basilic est une plante aromatique facile à cultiver en extérieur ou en intérieur, en pot ou en pleine terre. Très apprécié pour sa fraîcheur et sa saveur, il relève les plats de l'été. C'est un réel plaisir de le cueillir selon ses besoins." ,
#                       final_size: 0)
# if plant.photo.attached?
#   plant.photo.purge
# end
# file = File.open("./app/assets/images/plantes/basilic.jpg")
# # puts file
# plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
# # GardenPlant.create(nickname: "Basil", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)

# ###################################################################
# ###################################################################

# puts "Adding plants number 7"
# plant = Plant.create(name: "Dahlia",
#                       color: "pink",
#                       caducity: "Persistant",
#                       care_frequency: 1,
#                       water_need: 0,
#                       growth_speed: 1,
#                       cold_resistance: 2,
#                       light_need: 1,
#                       climate: [
#                         "Climat océanique",
#                         "Climat semi-océanique",
#                         "Climat continental",
#                         "Climat montagnard",
#                         "Climat méditerranéen"
#                       ],
#                       content: "Le dahlia, d’entretien facile, fleurit de juillet à novembre. Il existe un très grand nombre de variétés aux formes et hauteurs différentes et aux coloris variés. Il se cultive ainsi en pleine terre comme en bac." ,
#                       final_size: 0)
# if plant.photo.attached?
#   plant.photo.purge
# end
# file = File.open("./app/assets/images/plantes/dalia.jpg")
# # puts file
# plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
# # GardenPlant.create(nickname: "Dalida", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)

# ###################################################################
# ###################################################################

# puts "Adding plants number 8"
# plant = Plant.create(name: "Dipladenia",
#                       color: "pink",
#                       caducity: "Persistant",
#                       care_frequency: 1,
#                       water_need: 0,
#                       growth_speed: 1,
#                       cold_resistance: 2,
#                       light_need: 1,
#                       climate: [
#                         "Climat océanique",
#                         "Climat semi-océanique",
#                         "Climat continental",
#                         "Climat montagnard",
#                         "Climat méditerranéen"
#                       ],
#                       content: "Cette grimpante tropicale offre une floraison abondante et de longue durée, mise en valeur par un feuillage lustré et persistant. Elle participera au décor de la terrasse ou du balcon du printemps à l’automne." ,
#                       final_size: 0)
# if plant.photo.attached?
#   plant.photo.purge
# end
# file = File.open("./app/assets/images/plantes/dipladenia.jpg")
# # puts file
# plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
# # GardenPlant.create(nickname: "Dipladenia", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)

# ###################################################################
# ###################################################################

# puts "Adding plants number 9"
# plant = Plant.create(name: "Fraisier",
#                       color: "red",
#                       caducity: "Persistant",
#                       care_frequency: 1,
#                       water_need: 2,
#                       growth_speed: 1,
#                       cold_resistance: 2,
#                       light_need: 1,
#                       climate: [
#                         "Climat océanique",
#                         "Climat semi-océanique",
#                         "Climat continental",
#                         "Climat montagnard",
#                         "Climat méditerranéen"
#                       ],
#                       content: "À croquer tout juste cueillie, en dessert, sorbet ou confiture, elle est plébiscitée par les enfants et les grands. Petite fraise des bois ou fraise cultivée, elle fait l’unanimité pour son parfum exquis. C’est aussi l’un des premiers fruits au jardin." ,
#                       final_size: 0)
# if plant.photo.attached?
#   plant.photo.purge
# end
# file = File.open("./app/assets/images/plantes/fraisier.jpg")
# # puts file
# plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
# # GardenPlant.create(nickname: "Didier", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)

# ###################################################################
# ###################################################################

# puts "Adding plants number 10"
# plant = Plant.create(name: "Thym",
#                       color: "Green",
#                       caducity: "Persistant",
#                       care_frequency: 1,
#                       water_need: 0,
#                       growth_speed: 1,
#                       cold_resistance: 2,
#                       light_need: 1,
#                       climate: [
#                         "Climat océanique",
#                         "Climat semi-océanique",
#                         "Climat continental",
#                         "Climat montagnard",
#                         "Climat méditerranéen"
#                       ],
#                       content: "Plante aromatique aux multiples propriétés, le thym est répandu sur les rocailles du sud de la France. C'est une vivace connue pour son parfum caractéristique, son goût typé et ses petites feuilles couvertes de minuscules fleurs blanches ou roses." ,
#                       final_size: 0)
# if plant.photo.attached?
#   plant.photo.purge
# end
# file = File.open("./app/assets/images/plantes/thym.jpg")
# # puts file
# plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
# # GardenPlant.create(nickname: "Tim", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)
# #####################################################


puts "Adding plants number 1"
plant = Plant.create(name: "Clématite montana Broughton",
  color: "Pink",
  caducity: "Caduc",
  care_frequency: 1,
  water_need: 1,
  growth_speed: 1,
  cold_resistance: 2,
  light_need: [0, 1],
  climate: [
    "Climat océanique",
    "Climat semi-océanique",
    "Climat continental",
    "Climat montagnard",
    "Climat méditerranéen"
  ],
  content: "Les clématites sont considérées, à juste titre, comme les reines des lianes. Elles constituent certainement le groupe de plantes grimpantes le plus diversifié et le plus coloré.
  Leur souplesse permet de les cultiver dans des situations très variées. On les utilise en association avec les arbustes, les arbres, les haies, en couvre-sol ou en pots.
  Les clématites peuvent être à grandes fleurs, ou à fleur de plus petite taille comme les Alpina ou les Integrifolia. Certaines vont fleurir en été comme les Florida et d'autres au printemps comme les Montana.
  Elles sont classées en 3 groupes :
  - groupe 1 : les clématites persistantes, les Montana et les Alpina.
  - Groupe 2 : les clématites à grandes fleurs fleurissant sur le bois de l'année précédente puis la deuxième floraison sur la pousse de l'année.
  - Groupe 3 : Les clématites à grandes fleurs produisant une seule floraison sur la pousse de l'année.

  Espèce :
  Les clématites montana, clématites des montagnes ou bien clématites Anémones sont des lianes grimpantes à floraison printanière. Elles sont robustes et produisent une grande quantité de fleurs roses ou blanches au printemps. Le feuillage de cette espèce est caduc.

  Variété :
  Fleurs semi-doubles de couleur rose. Feuillage très découpé. Floraison très abondante." ,
  final_size: 2)
  if plant.photo.attached?
    plant.photo.purge
  end
  file = File.open("./app/assets/images/plantes/Clematite_montana_Broughton_Star_BENJAMIN.jpg")
  # puts file
  plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
  # GardenPlant.create(nickname: "Heuss", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)
########################

puts "Adding plants number 2"
plant = Plant.create(name: "Passiflore Caerulea",
  color: "Blue",
  caducity: "Caduc",
  care_frequency: 2,
  water_need: 1,
  growth_speed: 2,
  cold_resistance: 1,
  light_need: [0, 1],
  climate: [
    "Climat océanique",
    "Climat semi-océanique",
    "Climat continental",
    "Climat montagnard",
    "Climat méditerranéen"
  ],
  content: "Le genre Passiflora appartient la famille des passifloracées. Il est représenté par environ 500 espèces. La plupart sont des lianes ou plantes grimpantes volubiles.

  Espèce :
  Fleurs de 10 cm de diamètre légèrement parfumées et aux pétales et sépales bleutés. Leur couronne, assez large d'un bleu violacé est marquée d'un cercle blanc. Des fruits en forme d'oeufs orangés succèdent parfois aux fleurs. C'est sans conteste la plus rustique de toutes les espèces.

  Variété :
  Cette variété se distingue de l'espèce type par sa taille de fleur beaucoup plus imposante de la passiflore Caerulea. La couleur est relativement proche mais la passiflore Clear Sky résistera mieux en plein soleil." ,
  final_size: 0)
  if plant.photo.attached?
    plant.photo.purge
  end
  file = File.open("./app/assets/images/plantes/Passiflore_Caerulea_PAULETTE.jpg")
  # puts file
  plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
  # GardenPlant.create(nickname: "Heuss", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)
########################

puts "Adding plants number 3"
plant = Plant.create(name: "Passiflore caerulea clear sky",
  color: "Blue",
  caducity: "Caduc",
  care_frequency: 1,
  water_need: 1,
  growth_speed: 2,
  cold_resistance: 2,
  light_need: [0, 1],
  climate: [
    "Climat océanique",
    "Climat semi-océanique",
    "Climat continental",
    "Climat montagnard",
    "Climat méditerranéen"
  ],
  content: "Cette variété se distingue de l'espèce type par sa taille de fleur beaucoup plus imposante de la passiflore Caerulea. La couleur est relativement proche mais la passiflore Clear Sky résistera mieux en plein soleil. De plus, sa floraison est la plus longue ! Le genre Passiflora appartient à la famille des passifloracées. Il est représenté par environ 500 espèces. La plupart sont des lianes ou plantes grimpantes volubiles.

  Espèce :
  Fleurs de 10 cm de diamètre légèrement parfumées et aux pétales et sépales bleutés. Leur couronne, assez large d'un bleu violacé est marquée d'un cercle blanc. Des fruits en forme d'oeufs orangés succèdent parfois aux fleurs. C'est sans conteste la plus rustique de toutes les espèces.

  Variété :
  Cette variété se distingue de l'espèce type par sa taille de fleur beaucoup plus imposante de la passiflore Caerulea. La couleur est relativement proche mais la passiflore Clear Sky résistera mieux en plein soleil." ,
  final_size: 0)
  if plant.photo.attached?
    plant.photo.purge
  end
  file = File.open("./app/assets/images/plantes/Passiflore_caerulea_Clear_Sky_AGATHE.jpg")
  # puts file
  plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
  # GardenPlant.create(nickname: "Heuss", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)
########################

puts "Adding plants number 4"
plant = Plant.create(name: "Lierre des bois Helix",
  color: "Green",
  caducity: "Persistant",
  care_frequency: 1,
  water_need: 1,
  growth_speed: 0,
  cold_resistance: 2,
  light_need: [0, 1, 2],
  climate: [
    "Climat océanique",
    "Climat semi-océanique",
    "Climat continental",
    "Climat montagnard",
    "Climat méditerranéen"
  ],
  content: "Le lierre d'Irlande ou Hedera helix est une espèce très répandue dans les jardins d'ornement.
  Il s'agit d'une liane arbustive ou ligneuse. Ce lierre pousse à l'état sauvage dans les régions tempérées et se développe souvent spontanément dans les parties ombragées des jardins ou des haies.
  De couleur vert foncé, les feuilles sont légèrement découpées en 3 lobes. Elles mesurent environ 4 cm sur 6. Les lierres ou Hedera font partie de la famille des araliacées. Ce genre comprend environ 10 espèces. Le lierre est très utilisé comme plante grimpante, mais également comme couvre-sol très efficace. Ce genre est originaire d'Europe, d'Afrique et d'Asie.
  " ,
  final_size: 0)
  if plant.photo.attached?
    plant.photo.purge
  end
  file = File.open("./app/assets/images/plantes/Lierre_des_bois_Helix_LOUISE.jpg")
  # puts file
  plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
  # GardenPlant.create(nickname: "Heuss", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)
########################

puts "Adding plants number 5"
plant = Plant.create(name: "Clematite montana grandiflora",
                      color: "White",
                      caducity: "Caduc",
                      care_frequency: 1,
                      water_need: 1,
                      growth_speed: 1,
                      cold_resistance: 2,
                      light_need: [0, 1],
                      climate: [
                        "Climat océanique",
                        "Climat semi-océanique",
                        "Climat continental",
                        "Climat montagnard",
                        "Climat méditerranéen"
                      ],
                      content: "Très longue floraison se prolongeant jusqu'au début de l'été. Grandes fleurs blanches pures plus ou moins parfumées. Variété très rustique.Les clématites sont considérées, à juste titre, comme les reines des lianes. Elles constituent certainement le groupe de plantes grimpantes le plus diversifié et le plus coloré.
                      Leur souplesse permet de les cultiver dans des situations très variées. On les utilise en association avec les arbustes, les arbres, les haies, en couvre-sol ou en pots.
                      Les clématites peuvent être à grandes fleurs, ou à fleur de plus petite taille comme les Alpina ou les Integrifolia. Certaines vont fleurir en été comme les Florida et d'autres au printemps comme les Montana.
                      Elles sont classées en 3 groupes :
                      - groupe 1 : les clématites persistantes, les Montana et les Alpina.
                      - Groupe 2 : les clématites à grandes fleurs fleurissant sur le bois de l'année précédente puis la deuxième floraison sur la pousse de l'année.
                      - Groupe 3 : Les clématites à grandes fleurs produisant une seule floraison sur la pousse de l'année.

                      Les clématites montana, clématites des montagnes ou bien clématites Anémones sont des lianes grimpantes à floraison printanière. Elles sont robustes et produisent une grande quantité de fleurs roses ou blanches au printemps. Le feuillage de cette espèce est caduc." ,
                      final_size: 0)
if plant.photo.attached?
  plant.photo.purge
end
file = File.open("./app/assets/images/plantes/Clematite_montana_CLEMENTINE.jpg")
# puts file
plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
# GardenPlant.create(nickname: "Tim", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)
#####################################################


puts "Adding plants number 6"
plant = Plant.create(name: "Jasmin etoile asiaticum",
  color: "Yellow",
  caducity: "Persistant",
  care_frequency: 1,
  water_need: 1,
  growth_speed: 0,
  cold_resistance: 1,
  light_need: [0, 1],
  climate: [
    "Climat océanique",
    "Climat semi-océanique",
    "Climat continental",
    "Climat montagnard",
    "Climat méditerranéen"
  ],
  content: "Ses fleurs sont parfumées comme celles du jasmin mais ses feuilles sont persistantes en hiver.
  Les fleurs exhalent un parfum délicieux proche de celui du jasmin, mais plus fruité. De couleur blanche, ses fameuses fleurs en forme d'étoiles se regroupent en grappe. Le feuillage vert foncé bien que persistant perd quelques-unes de ses feuilles l'hiver, c'est seulement pour les renouveler !
  " ,
  final_size: 0)
  if plant.photo.attached?
    plant.photo.purge
  end
  file = File.open("./app/assets/images/plantes/Jasmin_etoile_asiaticum_JULES.jpg")
  # puts file
  plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
  # GardenPlant.create(nickname: "Heuss", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)
########################

puts "Adding plants number 7"
plant = Plant.create(name: "Jasmin etoile jasminoïde",
  color: "Blanc",
  caducity: "Persistant",
  care_frequency: 1,
  water_need: 1,
  growth_speed: 0,
  cold_resistance: 1,
  light_need: [0, 1],
  climate: [
    "Climat océanique",
    "Climat semi-océanique",
    "Climat continental",
    "Climat montagnard",
    "Climat méditerranéen"
  ],
  content: "Ses fleurs sont parfumées comme celles du jasmin mais ses feuilles sont persistantes en hiver.
  Les fleurs exhalent un parfum délicieux proche de celui du jasmin, mais plus fruité. De couleur blanche, ses fameuses fleurs en forme d'étoiles se regroupent en grappe. Le feuillage vert foncé bien que persistant perd quelques-unes de ses feuilles l'hiver, c'est seulement pour les renouveler !
  Le trachelospermum ou jasmin étoilé est une plante ligneuse. Ce genre comprend environ 15 espèces, dont les plus connus : le trachelospermum asiaticum, le trachelospermum jasmonoïdes et le trachelospermum lucidum." ,
  final_size: 0)
  if plant.photo.attached?
    plant.photo.purge
  end
  file = File.open("./app/assets/images/plantes/Jasmin_etoile_ jasminoides_JUSTIN.jpg")
  # puts file
  plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
  # GardenPlant.create(nickname: "Heuss", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)
########################

puts "Adding plants number 8"
plant = Plant.create(name: "Chevrefeuille japonica sinensis",
  color: "Pink",
  caducity: "Semi-Persistant",
  care_frequency: 1,
  water_need: 1,
  growth_speed: 0,
  cold_resistance: 2,
  light_need: [0, 1],
  climate: [
    "Climat océanique",
    "Climat semi-océanique",
    "Climat continental",
    "Climat montagnard",
    "Climat méditerranéen"
  ],
  content: "Les fleurs parfumées blanches et rouges contrastent bien avec le feuillage rouge pourpre.
  Le genre lonicera représente les plantes de la famille des Caprifoliacées. Il en existe environ 200 espèces de lianes ou d'arbuste.

  Le chèvrefeuille japonais est l'espèce de chèvrefeuille la plus connue. Originaire comme son nom l'indique du Japon et de l'Asie en règle générale. Cette espèce est caractérisée par son parfum puissant.
  " ,
  final_size: 0)
  if plant.photo.attached?
    plant.photo.purge
  end
  file = File.open("./app/assets/images/plantes/Chevrefeuille_japonica_Sinensis_CHARLOTTE.jpg")
  # puts file
  plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
  # GardenPlant.create(nickname: "Heuss", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)
########################

puts "Adding plants number 9"
plant = Plant.create(name: "Chevrefeuille Henry",
  color: "Yellow",
  caducity: "Persistant",
  care_frequency: 0,
  water_need: 1,
  growth_speed: 0,
  cold_resistance: 2,
  light_need: [0, 1],
  climate: [
    "Climat océanique",
    "Climat semi-océanique",
    "Climat continental",
    "Climat montagnard",
    "Climat méditerranéen"
  ],
  content: "Cette espèce de chèvrefeuille est considéré à juste titre par beaucoup comme plante de collectionneur. On met souvent à profit ce lonicera pour son feuillage persistant. Ses feuilles lancéolées, lisses et brillantes, sont de couleur verte. Ses fleurs rose saumon se groupent aux extrémités des pousses.
  Sa croissance rapide permet de l'utiliser pour garnir toute l'année un treillage et servir de fond à des fleurs plus précoces.
  Les fleurs sont roses à oranger et sont suivies de baies violettes toxiques pour l'homme.
  Elle garde ses feuilles l'hiver !
  Le genre lonicera représente les plantes de la famille des Caprifoliacées. Il en existe environ 200 espèces de lianes ou d'arbuste.
  " ,
  final_size: 0)
  if plant.photo.attached?
    plant.photo.purge
  end
  file = File.open("./app/assets/images/plantes/Chevrefeuille_Henry_HENRY.jpg")
  # puts file
  plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
  # GardenPlant.create(nickname: "Heuss", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)
########################

puts "Adding plants number 10"
plant = Plant.create(name: "Chevrefeuille japonica sinensis",
  color: "Pink",
  caducity: "Semi-Persistant",
  care_frequency: 1,
  water_need: 1,
  growth_speed: 0,
  cold_resistance: 2,
  light_need: [0, 1],
  climate: [
    "Climat océanique",
    "Climat semi-océanique",
    "Climat continental",
    "Climat montagnard",
    "Climat méditerranéen"
  ],
  content: "Les fleurs parfumées blanches et rouges contrastent bien avec le feuillage rouge pourpre.
  Le genre lonicera représente les plantes de la famille des Caprifoliacées. Il en existe environ 200 espèces de lianes ou d'arbuste.

  Le chèvrefeuille japonais est l'espèce de chèvrefeuille la plus connue. Originaire comme son nom l'indique du Japon et de l'Asie en règle générale. Cette espèce est caractérisée par son parfum puissant.
  " ,
  final_size: 0)
  if plant.photo.attached?
    plant.photo.purge
  end
  file = File.open("./app/assets/images/plantes/Chevrefeuille_japonica_Sinensis_CHARLOTTE_best.jpg")
  # puts file
  plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
  # GardenPlant.create(nickname: "Heuss", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)
########################



GardenPlant.find_each do |garden_plant|
  garden_plant.validated!
end

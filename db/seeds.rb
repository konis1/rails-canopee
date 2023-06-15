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

user = User.new(email: "test@test.fr", password: "123456")
user.save

puts "user Test added with password 123456"

puts "Adding plants"
counter = 1

Garden.create(user_id: user.id, name: "Fenêtre de cuisine", light: 0 , size:0 , care_willing: 0, location: "Paris,France")

puts "Adding plants number 1"
plant = Plant.create(name: "Heuchère",
  color: "Rouge",
  caducity: "Persistant",
  care_frequency: 1,
  water_need: 0,
  growth_speed: 0,
  cold_resistance: 0,
  light_need: 1,
  climate: [
    "Climat océanique",
    "Climat semi-océanique",
    "Climat continental",
    "Climat montagnard",
    "Climat méditerranéen"
  ],
  content: "L’heuchère est une plante vivace de la famille des Saxifragacées, originaire d’Amérique du Nord avec 50 espèces et aujourd’hui plus de 500 variétés horticoles cultivées." ,
  final_size: 0)
  if plant.photo.attached?
    plant.photo.purge
  end
  file = File.open("./app/assets/images/plantes/heuchère.jpg")
  # puts file
  plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
  # GardenPlant.create(nickname: "Heuss", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)

###################################################################
###################################################################

  puts "Adding plants number 2"
plant = Plant.create(name: "Ciboulette",
  color: "Green",
  caducity: "Persistant",
  care_frequency: 1,
  water_need: 0,
  growth_speed: 0,
  cold_resistance: 0,
  light_need: 1,
  climate: [
    "Climat océanique",
    "Climat semi-océanique",
    "Climat continental",
    "Climat montagnard",
    "Climat méditerranéen"
  ],
  content: "La ciboulette, superbe plante aromatique, se plaît dans le potager, jardin, terrasse et balcon. C'est une herbe indispensable pour relever nos plats cuisinés. Très facile à cultiver, elle possède, en outre, des vertus apéritives et digestives." ,
  final_size: 0)
  if plant.photo.attached?
    plant.photo.purge
  end
  file = File.open("./app/assets/images/plantes/ciboulette.jpg")
  # puts file
  plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
  GardenPlant.create(nickname: "Ciboul", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)

###################################################################
###################################################################

puts "Adding plants number 3"
plant = Plant.create(name: "Dionée",
                      color: "White",
                      caducity: "Persistant",
                      care_frequency: 1,
                      water_need: 1,
                      growth_speed: 1,
                      cold_resistance: 2,
                      light_need: 1,
                      climate: [
                        "Climat océanique",
                        "Climat semi-océanique",
                        "Climat continental",
                        "Climat montagnard",
                        "Climat méditerranéen"
                      ],
                      content: "La dionée (Dionaea) est la plus célèbre des plantes carnivores. Fascinante par ses pièges complexes et efficaces, elle se porte bien en culture extérieure si on la protège en hiver. Elle a besoin de soins attentifs, mais n'est pas d'une culture difficile." ,
                      final_size: 0)
if plant.photo.attached?
  plant.photo.purge
end
file = File.open("./app/assets/images/plantes/dionée.jpg")
# puts file
plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
# GardenPlant.create(nickname: "Dieudonnée", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)

###################################################################
###################################################################

puts "Adding plants number 4"
plant = Plant.create(name: "Fougère",
                      color: "Green",
                      caducity: "Persistant",
                      care_frequency: 1,
                      water_need: 1,
                      growth_speed: 1,
                      cold_resistance: 2,
                      light_need: 1,
                      climate: [
                        "Climat océanique",
                        "Climat semi-océanique",
                        "Climat continental",
                        "Climat montagnard",
                        "Climat méditerranéen"
                      ],
                      content: "Utilisé comme fougère d’intérieur depuis le XIXe siècle, le nephrolepis offre des frondes opulentes d’aspect décoratif. Il fait partie des plantes vertes basiques et résistantes facilement cultivables, même par ceux qui n’ont pas la main verte." ,
                      final_size: 0)
if plant.photo.attached?
  plant.photo.purge
end
file = File.open("./app/assets/images/plantes/fougère.jpg")
# puts file
plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
# GardenPlant.create(nickname: "Fouggiare", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)

###################################################################
###################################################################

puts "Adding plants number 5"
plant = Plant.create(name: "Lavande",
                      color: "Purple",
                      caducity: "Persistant",
                      care_frequency: 1,
                      water_need: 1,
                      growth_speed: 1,
                      cold_resistance: 2,
                      light_need: 1,
                      climate: [
                        "Climat océanique",
                        "Climat semi-océanique",
                        "Climat continental",
                        "Climat montagnard",
                        "Climat méditerranéen"
                      ],
                      content: "La lavande est un élégant arbrisseau qui symbolise la Provence et le soleil. Ses rameaux simples, touffus et dressés sont pourvus de feuilles vert cendré. Ses fleurs aux teintes pastel dégagent un parfum suave et pénétrant." ,
                      final_size: 0)
if plant.photo.attached?
  plant.photo.purge
end
file = File.open("./app/assets/images/plantes/lavande.jpg")
# puts file
plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
# GardenPlant.create(nickname: "Lavande", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)

###################################################################
###################################################################

puts "Adding plants number 6"
plant = Plant.create(name: "Basilic",
                      color: "Green",
                      caducity: "Persistant",
                      care_frequency: 1,
                      water_need: 1,
                      growth_speed: 1,
                      cold_resistance: 2,
                      light_need: 1,
                      climate: [
                        "Climat océanique",
                        "Climat semi-océanique",
                        "Climat continental",
                        "Climat montagnard",
                        "Climat méditerranéen"
                      ],
                      content: "Le basilic est une plante aromatique facile à cultiver en extérieur ou en intérieur, en pot ou en pleine terre. Très apprécié pour sa fraîcheur et sa saveur, il relève les plats de l'été. C'est un réel plaisir de le cueillir selon ses besoins." ,
                      final_size: 0)
if plant.photo.attached?
  plant.photo.purge
end
file = File.open("./app/assets/images/plantes/basilic.jpg")
# puts file
plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
GardenPlant.create(nickname: "Basil", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)

###################################################################
###################################################################

puts "Adding plants number 7"
plant = Plant.create(name: "Dahlia",
                      color: "pink",
                      caducity: "Persistant",
                      care_frequency: 1,
                      water_need: 1,
                      growth_speed: 1,
                      cold_resistance: 2,
                      light_need: 1,
                      climate: [
                        "Climat océanique",
                        "Climat semi-océanique",
                        "Climat continental",
                        "Climat montagnard",
                        "Climat méditerranéen"
                      ],
                      content: "Le dahlia, d’entretien facile, fleurit de juillet à novembre. Il existe un très grand nombre de variétés aux formes et hauteurs différentes et aux coloris variés. Il se cultive ainsi en pleine terre comme en bac." ,
                      final_size: 0)
if plant.photo.attached?
  plant.photo.purge
end
file = File.open("./app/assets/images/plantes/dalia.jpg")
# puts file
plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
# GardenPlant.create(nickname: "Dalida", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)

###################################################################
###################################################################

puts "Adding plants number 8"
plant = Plant.create(name: "Dipladenia",
                      color: "pink",
                      caducity: "Persistant",
                      care_frequency: 1,
                      water_need: 1,
                      growth_speed: 1,
                      cold_resistance: 2,
                      light_need: 1,
                      climate: [
                        "Climat océanique",
                        "Climat semi-océanique",
                        "Climat continental",
                        "Climat montagnard",
                        "Climat méditerranéen"
                      ],
                      content: "Cette grimpante tropicale offre une floraison abondante et de longue durée, mise en valeur par un feuillage lustré et persistant. Elle participera au décor de la terrasse ou du balcon du printemps à l’automne." ,
                      final_size: 0)
if plant.photo.attached?
  plant.photo.purge
end
file = File.open("./app/assets/images/plantes/dipladenia.jpg")
# puts file
plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
# GardenPlant.create(nickname: "Dipladenia", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)

###################################################################
###################################################################

puts "Adding plants number 9"
plant = Plant.create(name: "Fraisier",
                      color: "red",
                      caducity: "Persistant",
                      care_frequency: 1,
                      water_need: 1,
                      growth_speed: 1,
                      cold_resistance: 2,
                      light_need: 1,
                      climate: [
                        "Climat océanique",
                        "Climat semi-océanique",
                        "Climat continental",
                        "Climat montagnard",
                        "Climat méditerranéen"
                      ],
                      content: "À croquer tout juste cueillie, en dessert, sorbet ou confiture, elle est plébiscitée par les enfants et les grands. Petite fraise des bois ou fraise cultivée, elle fait l’unanimité pour son parfum exquis. C’est aussi l’un des premiers fruits au jardin." ,
                      final_size: 0)
if plant.photo.attached?
  plant.photo.purge
end
file = File.open("./app/assets/images/plantes/fraisier.jpg")
# puts file
plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
GardenPlant.create(nickname: "Didier", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)

###################################################################
###################################################################

puts "Adding plants number 10"
plant = Plant.create(name: "Thym",
                      color: "Green",
                      caducity: "Persistant",
                      care_frequency: 1,
                      water_need: 1,
                      growth_speed: 1,
                      cold_resistance: 2,
                      light_need: 1,
                      climate: [
                        "Climat océanique",
                        "Climat semi-océanique",
                        "Climat continental",
                        "Climat montagnard",
                        "Climat méditerranéen"
                      ],
                      content: "Plante aromatique aux multiples propriétés, le thym est répandu sur les rocailles du sud de la France. C'est une vivace connue pour son parfum caractéristique, son goût typé et ses petites feuilles couvertes de minuscules fleurs blanches ou roses." ,
                      final_size: 0)
if plant.photo.attached?
  plant.photo.purge
end
file = File.open("./app/assets/images/plantes/thym.jpg")
# puts file
plant.photo.attach(io: file, filename: "#{plant["name"]}.jpg", content_type: "image/jpg")
GardenPlant.create(nickname: "Tim", pot_color: "brown", garden_id: Garden.first.id, plant_id: plant.id)

GardenPlant.find_each do |garden_plant|
  garden_plant.validated!
end

# GardenPlant.find_each do |garden_plant|
#   puts garden_plant.tasks.first
#   # garden_plant.tasks.each do |task|
#   #   task.done_time = Time.now
#   # end
# end

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

filepath = File.join(Rails.root, 'db/plants.json')
serialized_plants = File.read(filepath)
plants = JSON.parse(serialized_plants)

puts "adding user test@test.fr"

user = User.new(email: "test@test.fr", password: "123456")
user.save

puts "user Test added with password 123456"

#how many plants we want
number_of_plants = 10

puts "Adding plants ..."
counter = 1

plants.each_with_index do |p, i|
  if i == number_of_plants
    break
  end
  puts "adding plant number #{counter}"
  speed = nil
  case p["growth_speed"]
  when "Lente"
    speed = 0
  when "Normale"
    speed = 1
  when "Rapide"
    speed = 2
  end
  p speed
  plant = Plant.create(name: p["name"],
                       color: p["color"],
                       caducity: p["caducity"],
                       care_frequency: p["care_frequency"],
                       water_need: p["water_need"],
                       growth_speed: speed,
                       cold_resistance: "cold_resistance",
                       light_need: "light_need",
                       climate: "climate",
                       final_size: "final_size")
  if plant.photo.attached?
    plant.photo.purge
  end
  file = URI.open(p["image_url"])
  plant.photo.attach(io: file, filename: "#{p["name"]}.jpg", content_type: "image/jpg")
  counter += 1
end

puts "Plants added !"

puts "Adding gardens"
number_of_gardens = 3

puts "Adding #{number_of_gardens} test gardens"
counter = 1

Garden.create(user_id: user.id, name: "Test", light: 1 , size: 3 , care_willing: 2, location: "16 villa gaudelet, Paris")
Garden.create(user_id: user.id, name: "My garden", light: 2 , size: 3 , care_willing: 2, location: "231 rue de belleville Paris")
Garden.create(user_id: user.id, name: "My balcony 2", light: 0 , size: 1 , care_willing: 3, location: "Lyon")

puts "Adding plants to the garden"

plants = Plant.all
gardens = Garden.all

plants.each do |p|
  GardenPlant.create(nickname: "test", pot_color: "blue", garden_id: gardens[rand(0..2)].id, plant_id: p.id)
end

GardenPlant.find_each do |garden_plant|
  garden_plant.validated!
end

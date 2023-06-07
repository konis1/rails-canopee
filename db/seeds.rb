# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or create!d alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


require "json"
require "pry-byebug"

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
  plant = Plant.create(name: p["name"], color: p["color"], caducity: p["caducity"],care_frequency: p["care_frequency"], water_need: p["water_need"], growth_speed: p["growth_speed"], cold_resistance: "cold_resistance",light_need: "light_need", climate: "climate", final_size: "final_size")
  if plant.photo.attached?
    plant.photo.purge
  end
  file = URI.open(p["image_url"])
  plant.photo.attach(io: file, filename: "#{p["name"]}.jpg", content_type: "image/jpg")
  counter += 1
end

puts "Plants added !"

# puts "Adding gardens"
# number_of_gardens = 2

puts "Adding one test garden"
# counter = 1

Garden.create(user_id: user.id, name: "Test", light: 1 , size: 3 , care_willing: 2, location: "16 villa gaudelet, Paris", color: "black" )

puts "Adding plants to the garden"

plants = Plant.all
plants.each do |p|
  GardenPlant.create(nickname: "test", pot_color: "blue", garden_id: Garden.first.id, plant_id: p.id)
end

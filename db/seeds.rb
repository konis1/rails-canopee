# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or create!d alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


require "json"

filepath = File.join(Rails.root, 'db/plants.json')
serialized_plants = File.read(filepath)
plants = JSON.parse(serialized_plants)

plants.each do |p|
 Plant.create(name: p["name"], color: p["color"], caducity: p["caducity"],care_frequency: p["care_frequency"], water_need: p["water_need"], growth_speed: p["growth_speed"], cold_resistance: "cold_resistance",light_need: "light_need", climate: "climate", final_size: "final_size", image_url: "image_url" )
end

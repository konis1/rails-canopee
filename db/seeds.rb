# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or create!d alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


User.destroy_all

# Create users
user1 = User.create!(email: "user1@example.com", password: "password1")
user2 = User.create!(email: "user2@example.com", password: "password2")

puts "Created users:"
puts user1.inspect
puts user2.inspect

# Create gardens
garden1 = Garden.create!(name: "Garden 1", light: 3, size: 2, care_willing: 4, location: "paris, France", latitude: 0, longitude: 1, color: "Green", user: user1)
garden2 = Garden.create!(name: "Garden 2", light: 2, size: 3, care_willing: 5, location: "brest, France", latitude: 0, longitude: 1, color: "Red", user: user2)

puts "Create!create!d gardens:"
puts garden1.inspect
puts garden2.inspect

# Create plants
plant1 = Plant.create!(name: "Rose Plant", color: "Red", caducity: "Deciduous", final_size: 80, light_need: 3, water_need: 4, growth_speed: 2, care_frequency: 2, cold_resistance: -5)
plant2 = Plant.create!(name: "Lily Plant", color: "White", caducity: "Evergreen", final_size: 60, light_need: 4, water_need: 3, growth_speed: 3, care_frequency: 3, cold_resistance: -2)

puts "Create!create!d plants:"
puts plant1.inspect
puts plant2.inspect

# Create garden plants
garden_plant1 = GardenPlant.create!(nickname: "Rose Plant", pot_color: "Green", plant: plant1, garden: garden1)
garden_plant2 = GardenPlant.create!(nickname: "Lily Plant", pot_color: "Blue", plant: plant2, garden: garden2)

puts "Create!create!d garden plants:"
puts garden_plant1.inspect
puts garden_plant2.inspect

# Create reviews
review1 = Review.create!(note: 4.5, content: "Beautiful plant", user: user1, plant: plant1)
review2 = Review.create!(note: 3.8, content: "Great addition to the garden", user: user2, plant: plant2)

puts "Create!create!d reviews:"
puts review1.inspect
puts review2.inspect

# Create tasks
task1 = Task.create!(activity: "Watering", criticity: "High", due_date: DateTime.now + 2.days, garden_plant: garden_plant1)
task2 = Task.create!(activity: "Pruning", criticity: "Medium", due_date: DateTime.now + 1.week, garden_plant: garden_plant2)

puts "Create!create!d tasks:"
puts task1.inspect
puts task2.inspect

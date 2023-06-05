class Plant < ApplicationRecord
  has_many :gardens, through: :garden_plants
  has_many :garden_plants
  has_many :reviews
  has_many :wishlist_plants
end

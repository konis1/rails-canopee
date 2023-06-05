class Wishlist < ApplicationRecord
  belongs_to :garden
  has_many :wishlist_plants
end

class GardenPlant < ApplicationRecord
  belongs_to :plant
  belongs_to :garden
  has_many :tasks
end

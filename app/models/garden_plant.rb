class GardenPlant < ApplicationRecord
  belongs_to :plant
  belongs_to :garden
  has_many :tasks
  validates :nickname, :pot_color, presence: true
  # validates :pot_color, inclusion: {in: %w()}
end

class GardenPlant < ApplicationRecord
  belongs_to :plant
  belongs_to :garden
  has_many :tasks
  validates :nickname, :pot_color, presence: true
  enum :status, {
    pre_selected: 0,
    selected: 10,
    validated: 20
  }
  # validates :pot_color, inclusion: {in: %w()}
end

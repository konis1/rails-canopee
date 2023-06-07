class GardenPlant < ApplicationRecord
  belongs_to :plant
  belongs_to :garden
  has_many :tasks, dependent: :destroy
  # validates :nickname, uniqueness: { scope: :garden_id }
  enum :status, {
    pre_selected: 0,
    selected: 10,
    validated: 20
  }
  # validates :pot_color, inclusion: {in: %w()}
end

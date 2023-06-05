class Plant < ApplicationRecord
  has_many :gardens, through: :garden_plants

end

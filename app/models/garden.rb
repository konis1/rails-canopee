class Garden < ApplicationRecord
  belongs_to :user
  has_many :plants, through: :garden_plants
  validates :light, :size, :location, presence: true
end

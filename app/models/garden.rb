class Garden < ApplicationRecord
  belongs_to :user
  has_many :plants, through: :garden_plants
  has_many :garden_plants, dependent: :destroy
  validates :light, :size, :location, presence: true
  validated :name, uniqueness: true
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end

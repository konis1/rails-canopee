class Garden < ApplicationRecord
  belongs_to :user
  has_many :garden_plants, dependent: :destroy
  has_many :plants, through: :garden_plants
  validates :light, :size, :location, presence: true
  validates :name, uniqueness: true
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  after_create_commit :associate_plants


  def associate_plants

    # garden = self
    # recuperer tyoutes les instances de plantes correspondant a ce jardin
    plants = Plant.where("? = ANY(climate)", "Climat #{self.climate}").where(
      light_need: self.light,
      care_frequency: self.care_willing
      # TODO add other criterias
    )
    # et créer les garden_plants correspondantes
    self.plants << plants
    save
  end

end

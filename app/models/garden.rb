class Garden < ApplicationRecord
  belongs_to :user
  has_many :garden_plants, -> { includes(:plant).order("plants.name desc") }, dependent: :destroy
  has_many :plants, -> { order(name: :desc) }, through: :garden_plants
  validates :light, presence: true
  # validates :name, uniqueness: true
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  after_create_commit :associate_plants


  # def associate_plants

  #   # garden = self
  #   # recuperer tyoutes les instances de plantes correspondant a ce jardin
  #   plants = Plant.where("? = ANY(climate)", "Climat #{self.climate}").where(
  #     light_need: self.light,
  #     care_frequency: self.care_willing
  #     # TODO add other criterias
  #   )
  #   # et créer les garden_plants correspondantes
  #   self.plants << plants
  #   save
  # end
  def associate_plants
    # Récupérer toutes les instances de plantes correspondant à ce jardin
    plants = Plant.where("? = ANY(climate)", "Climat #{self.climate}")

    # Filtrer les plantes en fonction du light_need
    if [0].include?(self.light)
      plants = plants.(Plant.where(light_need: [0]))
    elsif [2].include?(self.light)
      plants = plants.or(Plant.where(light_need: [2]))
    end

    # Filtrer les plantes en fonction du care_willing
    if [2].include?(self.care_willing)
      plants = plants.or(Plant.where(care_frequency: [2]))
    elsif [1].include?(self.care_willing)
      plants = plants.or(Plant.where(care_frequency: [1]))
    end

    # Créer les garden_plants correspondantes
    self.plants << plants
    save
  end




  def number_of_selected_plants
    garden_plants.selected.count
  end

  def number_of_remaining_plants
    garden_plants.count - garden_plants.where(status: ["selected", "refused"]).count
  end
end

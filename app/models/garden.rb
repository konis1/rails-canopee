class Garden < ApplicationRecord
  belongs_to :user
  has_many :garden_plants, -> { includes(:plant).order("plants.name desc") }, dependent: :destroy
  has_many :plants, -> { order(name: :desc) }, through: :garden_plants
  validates :light, presence: true
  # validates :name, uniqueness: true
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  after_create_commit :associate_plants


  def associate_plants
    # Récupérer toutes les instances de plantes correspondant à ce jardin en fonction des critères


    def careness
      # Vous semblez vouloir utiliser self.care_willing comme condition, mais cela doit être écrit correctement
      if self.care_willing == 0
        return Plant.where(care_frequency: 0)
      elsif self.care_willing == 1
        return (Plant.where(care_frequency: 0) + Plant.where(care_frequency: 1)).uniq
      else
        return (Plant.where(care_frequency: 0) + Plant.where(care_frequency: 1) + Plant.where(care_frequency: 2)).uniq
      end
    end

    # Sélectionner les plantes en fonction des critères et de la volonté de soins
    plants = Plant.where("? = ANY(climate)", "Climat #{self.climate}").where(light_need: self.light).merge(careness)

    # Ajouter les plantes au jardin
    self.plants << plants
    save
  end

  # def associate_plants
  #   # Récupérer toutes les instances de plantes correspondant à ce jardin
  #   plants = Plant.where("? = ANY(climate)", "Climat #{self.climate}")

  #   # Filtrer les plantes en fonction du light_need
  #   if [0].include?(self.light)
  #     plants = plants.(Plant.where(light_need: [0]))
  #   elsif [2].include?(self.light)
  #     plants = plants.or(Plant.where(light_need: [2]))
  #   end

  #   # Filtrer les plantes en fonction du care_willing
  #   if [2].include?(self.care_willing)
  #     plants = plants.or(Plant.where(care_frequency: [2]))
  #   elsif [1].include?(self.care_willing)
  #     plants = plants.or(Plant.where(care_frequency: [1]))
  #   end

  #   # Créer les garden_plants correspondantes
  #   self.plants << plants
  #   save
  # end




  def number_of_selected_plants
    garden_plants.selected.count
  end

  def number_of_remaining_plants
    garden_plants.count - garden_plants.where(status: ["selected", "refused"]).count
  end
end

class GardenPlant < ApplicationRecord
  NICKNAMES = ["Tim", "Paul", "Thomas", "Diane", "Cécile", "Jérémy", "Ursula", "Célia", "Julien", "Maxence", "Yass", "Germain", "Baptiste", "PY", "Jérôme", "Mathieu", "Nicolas", "Anthony", "Adonis", "Malika", "Youval", "Javier", "Hélène", "Jean-Baptiste", "Alexandre", "Stéphanie", "Céline", "Antoine", "Eugène", "Lucie", "Loic", "Titouan", "Arnaud", "Maxime", "Alexis", "Etienne", "Amal", "Clément", 'Lenny', "David", "Lesly", "Jules", "François", "Stéphanie", "Michel", "Michèle", "Matthieu", "Guillaume", "Romain", "Johnny", "Francis", "Hubert", "Patrick", "Nathalie", "Patricia", "John", "Jane", "Luc", "Marie", "Jésus", "Joseph", "Jonathan", "Joe", "Marc", "Julia", "Julie", "Julio", "Adeline", "Justine", "Alexander", "Daniel", "Daniella"]

  belongs_to :plant
  belongs_to :garden

  has_many :tasks, dependent: :destroy

  # validates :nickname, uniqueness: { scope: :garden_id }
  # validates :pot_color, inclusion: {in: %w()}

  after_update :create_initial_tasks
  after_create_commit :set_nickname

  enum :status, {
    pre_selected: 0,
    refused: 5,
    selected: 10,
    validated: 20
  }


  def score
    urgence = 0
    tasks = self.tasks
    tasks.each do |task|
      if task.done_time.nil?
        urgence += task.criticity.to_i * 10
      end
    end
    if urgence < 50 && urgence > 0
      return 50 - urgence
    else
      return 100 - urgence
    end
  end

  private

  def create_initial_tasks
    return unless validated?

    create_initial_repotting_task
    create_initial_watering_task
  end

  def create_initial_repotting_task
    if plant.growth_speed.zero?
      Task.create(activity: 'Rempote-moi !',
                  criticity: 0,
                  start_time: DateTime.now + 1.year,
                  due_date: DateTime.now + 1.year + 1.week,
                  garden_plant: self)
    elsif plant.growth_speed == 1
      Task.create(activity: 'Rempote-moi !',
                  criticity: 0,
                  start_time: DateTime.now + 2.year,
                  due_date: DateTime.now + 2.year + 1.week,
                  garden_plant: self)
    elsif plant.growth_speed == 2
      Task.create(activity: 'Rempote-moi !',
                  criticity: 0,
                  start_time: DateTime.now + 3.year,
                  due_date: DateTime.now + 3.year + 1.week,
                  garden_plant: self)
    end
  end

  def create_initial_watering_task
    Task.create(activity: 'Arrose-moi !',
                criticity: 2,
                start_time: DateTime.now,
                due_date: DateTime.now + 1.day,
                garden_plant: self)
  end

  def set_nickname
    available_nicknames = NICKNAMES.reject do |nickname|
      garden.garden_plants.select(:nickname).include?(nickname)
    end
    self.nickname = available_nicknames.sample
    save
  end
end

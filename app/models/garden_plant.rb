class GardenPlant < ApplicationRecord
  after_update :create_initial_tasks

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

  private

  def create_initial_tasks
    create_repot_task
    create_pruning_task
    create_harvest_task
  end

  def create_repot_task
    case growth_speed
    when 0 then Task.create(activity: 'Rempote-moi !', criticity: 'low', start_time: DateTime.now + 1.year, due_date: :start_time + 1.week)
    when 1 then Task.create(activity: 'Rempote-moi !', criticity: 'low', start_time: DateTime.now + 2.year, due_date: :start_time + 1.week)
    when 2 then Task.create(activity: 'Rempote-moi !', criticity: 'low', start_time: DateTime.now + 3.year, due_date: :start_time + 1.week)
    end
  end

  def create_pruning_task
    Task.create()
  end

  def create_harvest_task
    Task.create()
  end
end

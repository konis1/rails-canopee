class RetrieveGardenPlantsJob < ApplicationJob
  queue_as :default

  def perform(garden_id, weather_data)
    garden = Garden.find(garden_id)
    garden.garden_plants.each do |garden_plant|
      GenerateDailyTasksForPlantJob.perform_later(garden_plant.id, weather_data)
    end
  end
end

class RetrieveGardenPlantsJob
  include Sidekiq::Job

  def perform(garden_id, weather_data)
    garden = Garden.find(garden_id)
    garden.garden_plants.each do |garden_plant|
      GenerateDailyTasksForPlantJob.perform_async(garden_plant.id, weather_data)
    end
  end
end

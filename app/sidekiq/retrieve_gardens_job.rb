class RetrieveGardensJob
  include Sidekiq::Job

  def perform
    gardens = Garden.all
    gardens.each do |garden|
      weather_service = WeatherService.new(garden.latitude, garden.longitude, garden.location)
      weather_data = weather_service.retrieve_16_days_forecast
      RetrieveGardenPlantsJob.perform_async(garden.id, weather_data)
    end
  end
end

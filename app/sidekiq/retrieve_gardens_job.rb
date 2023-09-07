# Ce job récupère tous les jardins de la base de données pour itérer dessus. Il s'exécute de manière journalière
# comme défini par une expression cron située dans config/schedule.yml. Il fait appel à l'API météo afin de lui passer
# les coordonnées du jardin et de récupérer ses informations météorologiques.
class RetrieveGardensJob
  include Sidekiq::Job

  def perform
    gardens = Garden.all
    gardens.each do |garden|
      weather_service = WeatherService.new(garden.latitude, garden.longitude, garden.location)
      api_weather_data = weather_service.retrieve_16_days_forecast

      reworked_weather_data = {
        'min_temp_array' => api_weather_data[0],
        'max_temp_array' => api_weather_data[1],
        'rain_array' => api_weather_data[2],
        'dates_array' => api_weather_data[3],
        'past_min_temp_array' => api_weather_data[0].first(31),
        'past_max_temp_array' => api_weather_data[1].first(31),
        'past_rain_array' => api_weather_data[2].first(31),
        'past_dates_array' => api_weather_data[3].first(31),
        'today_max_temp' => api_weather_data[1][31],
        'today_min_temp' => api_weather_data[0][31],
        'today_rain' => api_weather_data[2][31],
        'forecast_min_temp_array' => api_weather_data[0].drop(32),
        'forecast_max_temp_array' => api_weather_data[1].drop(32),
        'forecast_rain_array' => api_weather_data[2].drop(32),
        'forecast_dates_array' => api_weather_data[3].drop(32)
      }

      RetrieveGardenPlantsJob.perform_async(garden.id, reworked_weather_data)
    end
  end
end

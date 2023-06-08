class RetrieveGardenPlantsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    args[0].plants.each do |plant|
      min_temp_array = weather_data[0]
      max_temp_array = weather_data[1]
      rain_array = weather_data[2]
      past_min_temp_array = min_temp_array.first(7)
      past_max_temp_array = max_temp_array.first(7)
      past_rain_array = rain_array.first(7)
      forecast_min_temp_array = min_temp_array.drop(7)
      forecast_max_temp_array = max_temp_array.drop(7)
      forecast_rain_array = rain_array.drop(7)
    end
  end
end

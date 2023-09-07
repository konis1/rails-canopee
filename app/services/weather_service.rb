require 'json'
require 'rest-client'

# Prends des arguments donnés par Geocoder, récupère la région concernée et de la donnée météo pour filtrer les plantes
# par climat.
class WeatherService
  def initialize(latitude, longitude, location)
    @location = "#{location.split(',')[0]}, France"
    @latitude = latitude
    @longitude = longitude
    @weather_api = "https://api.open-meteo.com/v1/forecast"
    @geocoding_api = "https://geocoding-api.open-meteo.com/v1/search"
  end

  # J'ai assemblé ce classement des régions et climats de France de manière assez grossière basée sur les indications
  # pas hyper précises d'Ooreka. Ca serait bien de trouver un moyen d'obtenir des données climatiques très précises sur
  # chaque lieu. L'API Open Meteo qu'on utilise à apperemment une fonction intéressante de données historiques.
  CONTINENTAL = ['Grand Est', 'Bourgogne-Franche-Comté']
  OCEANIQUE = ['Bretagne', 'Pays de la Loire', 'Nouvelle-Aquitaine']
  SEMI_OCEANIQUE = ['Île-de-France', 'Hauts-de-France']
  MEDITERRANEEN = ['Occitanie', "Provence-Alpes-Côte d'Azur", 'Corse']
  MONTAGNARD = ['Auvergne-Rhône-Alpes']

  def retrieve_daily_rain_data
    forecast_response = RestClient.get @weather_api, { params: { latitude: @latitude,
                                                                 longitude: @longitude,
                                                                 daily: 'rain_sum',
                                                                 forecast_days: 16,
                                                                 timezone: 'Europe/London' } }
    JSON.parse(forecast_response)['daily']['rain_sum'][0]
  end

  def retrieve_rain_data_16_days
    forecast_response = RestClient.get @weather_api, { params: { latitude: @latitude,
                                                                 longitude: @longitude,
                                                                 daily: 'rain_sum',
                                                                 forecast_days: 16,
                                                                 timezone: 'Europe/London' } }
    JSON.parse(forecast_response)['daily']['rain_sum']
  end

  def retrieve_min_temp_16_days
    forecast_response = RestClient.get @weather_api, { params: { latitude: @latitude,
                                                                 longitude: @longitude,
                                                                 daily: 'temperature_2m_min',
                                                                 forecast_days: 16,
                                                                 timezone: 'Europe/London' } }
    JSON.parse(forecast_response)['daily']['temperature_2m_min']
  end

  def retrieve_16_days_forecast
    forecast_response = RestClient.get @weather_api, { params: { latitude: @latitude,
                                                                 longitude: @longitude,
                                                                 daily: 'temperature_2m_max,temperature_2m_min,rain_sum',
                                                                 past_days: 31,
                                                                 forecast_days: 16,
                                                                 timezone: 'Europe/London' } }
    data = JSON.parse(forecast_response)['daily']
    [data['temperature_2m_min'], data['temperature_2m_max'], data['rain_sum'], data['time']]
  end

  def determine_climate
    location_region = retrieve_region rescue 'continental'
    locate_in_climate_map(location_region)
  end

  def determine_weather_of_the_hour
    current_hour = Time.now.hour
    hourly_weather = retrieve_hourly_weather
    if hourly_weather['rain'][current_hour].positive? && ['hourly']['rain'][current_hour] < 5.0
      'drizzle'
    elsif hourly_weather['rain'][current_hour] > 5.0
      'rainy'
    elsif hourly_weather['cloudcover'][current_hour] < 30
      'sunny'
    elsif hourly_weather['cloudcover'][current_hour] > 30
      'cloudy'
    else
      'checking weather...'
    end
  end

  def retrieve_hourly_weather
    hourly_weather = RestClient.get @weather_api, { params: { latitude: @latitude,
                                             longitude: @longitude,
                                             hourly: 'temperature_2m,rain,cloudcover',
                                             forecast_days: 1,
                                             timezone: 'Europe/London' } }
    JSON.parse(hourly_weather)['hourly']
  end

  private

  def retrieve_region
    location_data = RestClient.get @geocoding_api, { params: { name: @location, count: 10, language: 'fr', format: 'json' } }
    JSON.parse(location_data)['results'][0]['admin1']
  end

  def locate_in_climate_map(region)
    if CONTINENTAL.include?(region)
      'continental'
    elsif OCEANIQUE.include?(region)
      'océanique'
    elsif SEMI_OCEANIQUE.include?(region)
      'semi-océanique'
    elsif MEDITERRANEEN.include?(region)
      'méditerranéen'
    elsif MONTAGNARD.include?(region)
      'montagnard'
    end
  end
end

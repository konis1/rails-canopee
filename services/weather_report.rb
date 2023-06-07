require 'json'
require 'rest-client'

# Takes arguments given by Geocoder, gets weather data and region to filter plants by climate.
class WeatherService
  def initialize(latitude, longitude, location)
    @location = "#{location.split(',')[0]}, France"
    @latitude = latitude
    @longitude = longitude
    @weather_api = "https://api.open-meteo.com/v1/forecast"
    @geocoding_api = "https://geocoding-api.open-meteo.com/v1/search"
  end

  CONTINENTAL = ['Grand Est', 'Bourgogne-Franche-Comté']
  OCEANIQUE = ['Bretagne', 'Pays de la Loire', 'Nouvelle-Aquitaine']
  SEMI_OCEANIQUE = ['Île-de-France', 'Hauts-de-France']
  MEDITERRANEEN = ['Occitanie', "Provence-Alpes-Côte d'Azur", 'Corse']
  MONTAGNARD = ['Auvergne-Rhône-Alpes']

  def retrieve_day_rain
    forecast_response = RestClient.get @weather_api, { params: { latitude: @latitude, longitude: @longitude, daily: 'rain_sum', forecast_days: 16, timezone: 'Europe%2FLondon' } }
    JSON.parse(forecast_response)['daily']['rain_sum'][0]
  end

  def determine_climat
    location_region = retrieve_region
    locate_in_climate_map(location_region)
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

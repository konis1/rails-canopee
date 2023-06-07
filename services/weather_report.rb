require 'json'
require 'open-uri'
require 'rest-client'

# Takes arguments given by Geocoder, gets weather data and region to filter plants by climate.
class WeatherService
  def initialize(latitude, longitude, location)
    @location = location
    @weather_api = "https://api.open-meteo.com/v1/search"
    @geocoding_api = "https://geocoding-api.open-meteo.com/v1/search?name=#{@location}&count=10&language=fr&format=json"
  end

  CONTINENTAL = ['Grand Est', 'Bourgogne-Franche-Comté']
  OCEANIQUE = ['Bretagne', 'Pays de la Loire', 'Nouvelle-Aquitaine']
  SEMI_OCEANIQUE = ['Île-de-France', 'Hauts-de-France']
  MEDITERRANEEN = ['Occitanie', "Provence-Alpes-Côte d'Azur", 'Corse']
  MONTAGNARD = ['Auvergne-Rhône-Alpes']

  def retrieve_day_rain
    JSON.parse(URI.open(@weather_api).read)['daily']['rain_sum'][0]
  end

  def determine_climate
    response = RestClient.get 'https://geocoding-api.open-meteo.com/v1/search', {params: {name: @location, language: "fr"}}
    @json = JSON.parse(response.body)
    location_region = retrieve_region
    locate_in_climate_map(location_region)
  end

  private

  def retrieve_region
    @json['results'][0]['admin1'] rescue ""
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

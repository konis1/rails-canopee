require 'nokogiri'
require 'open-uri'
require 'json'
require 'pry-byebug'


# list = ['basilic', 'thym', 'ciboulette', 'geranium', 'capucine', 'dahlia', 'jasmin+etoile', 'lavande', 'chevrefeuille', 'piment', 'fraise', 'tomate', 'lierre', 'nephrolepsis', 'heuchere', 'dionee', 'sarracenia', 'drosera']
  
class OorekaScrapper
  attr_reader :plants

  def initialize(attr = {})
    @plants = []
    @plant_urls = []
  end

  def scrap
    alphabet = ("a".."z").to_a
    alphabet.each { |letter| scrap_pages(letter) }
    scrap_plants
  end

  def extract_json!(path)
    json_data = JSON.pretty_generate(@plants)
    File.open(path, 'w') { |file| file.write(json_data) }
  end
  
  private

  def scrap_pages(letter)
    url = "https://jardinage.ooreka.fr/plante/rechercheAlpha/#{letter}"
    search_page = URI.open(url).read
    noko_doc = Nokogiri::HTML.parse(search_page)
    pages_count = noko_doc.search('.pagination_unite a').count
    pages_count.times do |n|
      page_number = n + 1
      page_url = page_number == 1 ? url : "#{url}/#{page_number}"
      scrap_page(page_url)
    end
  end

  def scrap_page(url)
    search_page = URI.open(url).read
    noko_doc = Nokogiri::HTML.parse(search_page)
    noko_doc.search('.titre_liste_plante').each do |plant|
      @plant_urls << "https://jardinage.ooreka.fr#{plant.attributes["href"].value}"
    end
  end

  def scrap_plants
    @plant_urls.each do |plant_url|
      search_page = URI.open(plant_url).read
      doc = Nokogiri::HTML.parse(search_page)
      plant_doc = doc.css('#resume_plante')

      begin
        puts "\n\n#{find_name_for(doc)} scrapping"
        plant_data = {
          name: find_name_for(doc),
          color: find_flowers_color_for(plant_doc),
          # leaves: find_leaves_color_for(plant_doc),
          caducity: find_leaves_type_for(plant_doc),
          care_frequency: find_care_need_for(plant_doc),
          water_need: find_water_need_for(plant_doc),
          growth_speed: find_grow_speed_for(plant_doc),
          cold_resistance: find_cold_resistance_for(plant_doc),
          light_need: find_sun_needed_for(plant_doc),
          climate: find_climate_need_for(plant_doc),
          final_size: find_final_size_for(plant_doc),
          image_url: find_image_url_for(doc),
          desription: find_description_for(doc),
        }
        @plants << plant_data
      rescue NoMethodError
        puts "\n\n#{find_name_for(doc)} scrapping failed 🥲"
        next
      end
      
    end
  end

  def find_name_for(doc)
    doc.css('h1').text.strip
  end

  def find_flowers_color_for(plant_doc)
    plant_doc.search(".couleur_fleur span").first.attributes["class"].value.split.first.gsub("fleur_", '')
  end

  # def find_leaves_color_for(plant_doc)
  #   plant_doc.search(".couleur_feuille span").first.attributes["class"].value.split.first.gsub("feuille_", '')
  # end

  def find_final_size_for(plant_doc)
    plant_doc.search('p:contains("Largeur à maturité")').first.parent.search("span").text.strip.scan(/^[\d\.]+/).first.to_f
  end

  def find_leaves_type_for(plant_doc)
    plant_doc.search('p:contains("Feuillage")').first.parent.search('.bulle_info2').first.text.split.first.downcase.gsub('-', '_')
  end

  def find_care_need_for(plant_doc)
    if plant_doc.search('.niveau_entretien_easy').any?
      return 0
    elsif plant_doc.search('.niveau_entretien_moderate').any?
      return 1
    elsif plant_doc.search('.niveau_entretien_hard').any?
      return 2
    else
      return 1
    end
  end

  def find_water_need_for(plant_doc)
    if plant_doc.search('.besoin_eau_low').any?
      return 0
    elsif plant_doc.search('.besoin_eau_medium').any?
      return 1
    elsif plant_doc.search('.besoin_eau_high').any?
      return 2
    else
      return 1
    end
  end

  def find_grow_speed_for(plant_doc)
    plant_doc.search('p:contains("Croissance")').first.parent.search('.bulle_info2').first.text.strip.split.first
  end

  def find_cold_resistance_for(plant_doc)
    if plant_doc.search('.resistance_fragile').any?
      return 0
    elsif plant_doc.search('.resistance_proteger').any?
      return 1
    elsif plant_doc.search('.resistance_rustique').any?
      return 2
    else
      return 1
    end
  end

  def find_sun_needed_for(plant_doc)
    if plant_doc.search('.exposition_soleil').any?
      return 0
    elsif plant_doc.search('.exposition_mi_ombre').any?
      return 1
    elsif plant_doc.search('.exposition_ombre').any?
      return 2
    else
      return 1
    end
  end

  def find_image_url_for(doc)
    doc.search('.img_intro').first.attributes['src'].value
  end

  def find_climate_need_for(plant_doc)
    plant_doc.search('p:contains("Climat")').first.parent.search('.span_bulle_info2._informationTooltips').map(&:text)
  end

  def find_description_for(doc)
    doc.search(".intro_courte_plantes").first.text.strip
  end
end

scrapper = OorekaScrapper.new
scrapper.scrap
puts scrapper.plants.count
# puts scrapper.plants
scrapper.extract_json!(File.join(__dir__, 'plants.json'))
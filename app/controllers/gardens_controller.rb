class GardensController < ApplicationController
  before_action :set_garden, only: %i[show edit update destroy select_plants crush validate_plants]

  def index
    @gardens = Garden.all
  end

  def show
    weather_checker = WeatherService.new(@garden.latitude, @garden.longitude, @garden.location)
    @hourly_weather = weather_checker.determine_weather_of_the_hour
    @weather_json = weather_checker.retrieve_hourly_weather
  end

  def new
    @garden = Garden.new
  end

  def create
    @garden = Garden.new(garden_params)
    @garden.user = current_user
    climate_checker = WeatherService.new(@garden.latitude, @garden.longitude, @garden.location)
    @garden.climate = climate_checker.determine_climate

    if @garden.save
      redirect_to select_plants_path(@garden), notice: 'Garden was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @garden.update(garden_params)
      redirect_to select_plants_path(@garden), notice: 'Garden was successfully updated.'
    else
      render :edit, status: :unprocessable_entity

    end
  end

  def destroy
    @garden.destroy
    redirect_to gardens_path, notice: 'Garden was successfully destroyed.'
  end

  # Valide le choix final de plantes d'un jardin et renvoie vers une demande d'infos de livraison.
  def validate_plants
    # garden_plants = GardenPlant.where(id: params.dig(:garden_plant, :choices))
    garden_plants = @garden.garden_plants.selected.all
    garden_plants.each(&:validated!)

    redirect_to retrieve_delivery_info_path(@garden)
  end

  def select_plants
    @garden_plants = @garden.garden_plants
  end

  def crush
    @garden_plants = @garden.garden_plants.selected.all
  end

  private

  def set_garden
    @garden = Garden.find(params[:id])
  end

  def garden_params
    params.require(:garden).permit(:name, :light, :size, :care_willing, :location, :color)
  end
end

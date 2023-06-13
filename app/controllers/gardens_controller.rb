class GardensController < ApplicationController
  before_action :set_garden, only: [:show, :edit, :update, :destroy, :select_plants]


  def index
    @gardens = Garden.all
  end

  def show
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
      redirect_to garden_path(@garden), notice: 'Garden was successfully updated.'
    else
      render :edit, status: :unprocessable_entity

    end
  end

  def destroy
    @garden.destroy
    redirect_to gardens_path, notice: 'Garden was successfully destroyed.'
  end

  def validate_plants
    @garden = Garden.find(params[:id])
    garden_plants = GardenPlant.where(id: params.dig(:garden_plant, :choices))
    garden_plants.each(&:validated!)
    redirect_to garden_path(@garden)
  end

  def select_plants
    @garden_plants = @garden.garden_plants
  end

  def crush
    @garden_plants = Garden.last.garden_plants.selected.all
  end


  private

  def set_garden
    @garden = Garden.find(params[:id])
  end

  def garden_params

    params.require(:garden).permit(:name, :light, :size, :care_willing, :location, :color)

  end
end

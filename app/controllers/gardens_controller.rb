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
      redirect_to @garden, notice: 'Garden was successfully updated.'
    else
      render :edit, status: :unprocessable_entity

    end
  end

  def destroy
    @garden.destroy
    redirect_to gardens_url, notice: 'Garden was successfully destroyed.'
  end

  def validate_plants
    @garden = Garden.find(params[:garden_id])
    choices = params[:garden_plant][:choices]

      choices.each do |garden_plant_id|
        garden_plant = @garden.garden_plants.find(garden_plant_id)
        garden_plant.validated!
      end
    redirect_to @garden
  end

  def select_plants

  end


  private

  def set_garden
    @garden = Garden.find(params[:id])
  end

  def garden_params

    params.require(:garden).permit(:name, :light, :size, :care_willing, :location, :color)

  end
end

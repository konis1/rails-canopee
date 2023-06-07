class GardenPlantsController < ApplicationController
  before_action :set_garden_plant, only: [:show, :edit, :update, :destroy]

  def index
    @garden_plants = current_user.garden_plants
    @garden_plants = @garden.garden_plants
  end

  def show
  end


  def new
    @garden_plant = @garden.garden_plants.new
  end

  def create
    @garden = Garden.find(params[:garden_id])
    @garden_plant = @garden_plants.new(garden_plant_params)
    @garden_plant.garden = @garden

    if @garden_plant.save
      redirect_to garden_plant_path(@garden_plant), notice: 'Garden plant was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @garden_plant.update(garden_plant_params)
      redirect_to garden_plant_path(@garden_plant), notice: 'Garden plant was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @garden_plant.destroy
    redirect_to garden_plants_path, notice: 'Garden plant was successfully destroyed.'
  end

  private

  def set_garden_plant
    @garden_plant = Garden_plants.find(params[:id])
  end

  def garden_plant_params
    params.require(:garden_plant).permit(:nickname, :pot_color, :plant_id)
  end
end

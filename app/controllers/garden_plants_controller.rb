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
      @garden = @garden_plant.garden
      finished = @garden.number_of_remaining_plants == 0
      respond_to do |format|
        format.json { render json: { garden_plant_count: @garden.number_of_selected_plants, remaining_plants: @garden.number_of_remaining_plants, finished: finished, garden_crush_path: crush_path(@garden) } }
        format.html { redirect_to garden_plant_path(@garden_plant), notice: 'Garden plant was successfully updated.'}
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @garden_plant.destroy
    redirect_to garden_path(@garden_plant.garden), notice: 'Garden plant was successfully destroyed.' if @garden_plant.validated?
    redirect_to crush_path(@garden_plant.garden), notice: 'Garden plant was successfully destroyed.' if @garden_plant.selected?
  end

  private

  def set_garden_plant
    @garden_plant = GardenPlant.find(params[:id])
  end

  def garden_plant_params
    params.require(:garden_plant).permit(:nickname, :pot_color, :plant_id, :status)
  end
end

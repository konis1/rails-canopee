class GardensController < ApplicationController
  before_action :set_gardenp, only: %i[show edit update destroy]

  def index
    @gardens = Garden.all
  end

  def show
  end

  def edit
  end

  def create
    @garden = Garden.new(garden_params)
    @garden.user = current_user
    if @garden.save
      redirect_to garden_path(@garden), notice: "Your garden is successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end


  def update
    if @garden.update(garden_params)
      redirect_to garden_path(@garden), notice: "your garden was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @garden.destroy
    redirect_to gardens_path, notice: "your garden was successfully destroyed 💥"
  end

  private

  def set_garden
    @garden = Garden.find(params[:id])
  end

  def garden_params
    params.require(:garden).permit(:name, :light, :size, :care_willing, :location, :latitude, :longitude, :color)
  end

end

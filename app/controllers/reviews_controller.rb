class ReviewsController < ApplicationController
  before_action :set_plant, only: [ :index, :new, :create, :show ]

  def index
    @reviews = Review.find(params[:plant_id])
  end

  def new
    @review = Review.new

  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.plant = Plant.find(params[:plant_id])
    @review.save
    redirect_to plant_path(@plant.garden)
  end

  def show
    @review = Review.find(params[:plant_id])
  end


  private

  def review_params
    params.require(:review).permit(:content, :note)
  end

  def set_plant
    @plant = Plant.find(params[:plant_id])
  end
end

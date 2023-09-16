class RegistrationsController < ApplicationController
  def show
    @user = User.find(params[:id])
    @gardens = Garden.where(receiver_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)

    if @user.save
      redirect_to gardens_path(@user)
    else
      render "new"
    end
  end

  private

    def user_params
      params.require(:user).permit(:prenom, :nom)
    end
end

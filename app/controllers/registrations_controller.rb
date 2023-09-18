class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to gardens_path(@garden), notice: 'Bienvenue, votre compte a été créé avec succès'
    else
      render :new, status: :unprocessable_entity
    end
  end

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
      redirect_to gardens_path(@garden)
    else
      render "new"
    end
  end

  # Action utilisée pour afficher un formulaire d'édition des infos de livraison et d'achat de l'utilisateur et
  # envoyer ces données à une action UPDATE customisée.
  def retrieve_delivery_info
    @user = Garden.find(params[:id]).user
    raise
  end

  private

  def user_params
    params.require(:user).permit(:phone_number, :address, :adresse_ville, :adresse_code_postal, :code_achat)
  end
end

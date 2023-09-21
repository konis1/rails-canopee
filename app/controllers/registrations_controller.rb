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
  def edit_delivery_info
    @user = User.find(params[:id])

    render 'devise/registrations/edit_delivery_info'
  end

  def update_delivery_info
    @user = User.find(params[:id])
    @user.update(delivery_params)
    @user.placed_order = true

    if @user.save
      ApplicationMailer.welcome_email(current_user).deliver_now
      redirect_to merci_path(@user)
    else
      render 'devise/registrations/edit_delivery_info', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

  def delivery_params
    params.require(:user).permit(:nom, :prenom, :phone_number, :adresse_numero, :adresse_type_voie, :adresse_nom_voie, :adresse_code_postal, :adresse_ville, :adresse_infos_complementaires_1, :adresse_infos_complementaires_2)
  end
end

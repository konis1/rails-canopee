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
    @user.phone_number = format_tel_number(@user.phone_number)
    @user.nom = @user.nom.downcase
    @user.prenom = @user.prenom.downcase
    @user.adresse_type_voie = @user.adresse_type_voie.downcase
    @user.adresse_nom_voie = @user.adresse_nom_voie.downcase
    @user.adresse_ville = @user.adresse_ville.downcase

    if @user.save
      # ApplicationMailer.welcome_email(current_user).deliver_now
      redirect_to merci_path(@user)
    else
      render 'devise/registrations/edit_delivery_info', status: :unprocessable_entity
    end
  end

  def format_tel_number(number)
    number.gsub!(" ", "")
    number.gsub(".", "")
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

  def delivery_params
    params.require(:user).permit(:nom, :prenom, :phone_number, :adresse_numero, :adresse_type_voie, :adresse_nom_voie, :adresse_code_postal, :adresse_ville, :adresse_infos_complementaires_1, :adresse_infos_complementaires_2)
  end
end

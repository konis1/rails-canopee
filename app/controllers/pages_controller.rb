class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home merci]

  def home; end

  # Action chargée d'afficher une page de remerciements après passage d'une commande de plantes et récupération des
  # coordonnées de l'utilisateur.
  def merci
    @user = User.find(params[:id])
  end
end

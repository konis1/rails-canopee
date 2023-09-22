class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :set_notifications
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  private

  def set_notifications
    if user_signed_in?
      @notifications = current_user.notifications
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nom, :prenom, :phone_number, :adresse_numero, :adresse_type_voie, :adresse_nom_voie, :adresse_code_postal, :adresse_ville, :adresse_infos_complementaires_1, :adresse_infos_complementaires_2])
  end
end

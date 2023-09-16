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
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone_number, :address, :adresse_ville, :adresse_code_postal, :code_achat])
  end
end

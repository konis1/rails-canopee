class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :set_notifications

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  private

  def set_notifications
    if user_signed_in?
      @notifications = current_user.notifications
    end
  end
end

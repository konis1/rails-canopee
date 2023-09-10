class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :merci ]

  def home; end
  def merci; end


end

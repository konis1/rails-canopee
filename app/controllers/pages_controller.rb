class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def cover1
  end
  def cover2
  end
  def cover3
  end
end

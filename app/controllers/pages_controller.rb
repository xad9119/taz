class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    p params
  end
end

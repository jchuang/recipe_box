class PagesController < ApplicationController

  skip_before_action :authenticate_user!

  def welcome
    redirect_to recipes_path if current_user
  end

end

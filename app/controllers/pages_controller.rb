class PagesController < ApplicationController

  def welcome
    redirect_to recipes_path if current_user
  end

end

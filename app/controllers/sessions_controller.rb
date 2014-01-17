class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_url, notice: 'Welcome to RecipeBox!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'You have successfully signed out.'
  end

  def failure
    redirect_to root_url, alert: 'Authentication failed, please try again.'
  end

end

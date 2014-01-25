class TagsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @tags = Tag.where(user_id: params[:user_id])
    @user = User.find(params[:user_id])
    @tag = Tag.new
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.user = current_user

    if @tag.save
      flash[:notice] = 'Your tag was successfully added.'
      redirect_to user_tags_path(current_user)
    else
      flash[:alert] = 'There was an issue with your tag. Please try again.'
      redirect_to user_tags_path(current_user)
    end
  end

  def edit
    @tag = Tag.find(params[:id])
    authorize_user(@tag)
  end

  def update
    @tag = Tag.find(params[:id])
    authorize_user(@tag)

    if @tag.update(tag_params)
      flash[:notice] = 'Your tag was successfully updated.'
      redirect_to user_tags_path(current_user)
    else
      flash[:alert] = 'There was an issue with your tag. Please try again.'
      render :edit
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    authorize_user(@tag)

    @tag.destroy
    flash[:notice] = 'Your tag was successfully deleted.'
    redirect_to user_tags_path(current_user)
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  def authorize_user(tag)
    unless user_signed_in? and (tag.user == current_user)
      raise ActionController::RoutingError.new('The page you requested was not found.')
    end
  end
end

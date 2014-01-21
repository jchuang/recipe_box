class TagsController < ApplicationController

  def index
    @tags = Tag.all
    @tag = Tag.new
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def create
    check_authentication
    @tag = Tag.new(tag_params)
    @tag.user = current_user

    if @tag.save
      redirect_to user_tags_path(current_user), notice: 'Your tag was successfully added.'
    else
      redirect_to user_tags_path(current_user), notice: 'There was an issue with your tag. Please try again.'
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
      redirect_to user_tags_path(current_user), notice: 'Your tag was successfully updated.'
    else
      render :edit, notice: 'There was an issue with your tag. Please try again.'
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    authorize_user(@tag)

    @tag.destroy
    redirect_to user_tags_path(current_user), notice: 'Your tag was successfully deleted.'
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

  def check_authentication
    unless user_signed_in?
      raise ActionController::RoutingError.new('The page you requested was not found.')
    end
  end
end

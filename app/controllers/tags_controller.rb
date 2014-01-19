class TagsController < ApplicationController

  def index
    @tags = Tag.all
    @tag = Tag.new
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.user = current_user

    if @tag.save
      redirect_to tags_path, notice: 'Your tag was successfully added.'
    else
      redirect_to tags_path, notice: 'There was an issue with your tag. Please try again.'
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])

    if @tag.update(tag_params)
      redirect_to tags_path, notice: 'Your tag was successfully updated.'
    else
      render :edit, notice: 'There was an issue with your tag. Please try again.'
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to tags_path, notice: 'Your tag was successfully deleted.'
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end

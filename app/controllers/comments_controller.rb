class CommentsController < ApplicationController

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.new(comment_params)
    @comment.recipe = @recipe
    @comment.user = current_user

    if @comment.save
      flash[:notice] = 'Your comment was successfully added.'
      redirect_to recipe_path(@recipe)
    else
      flash[:alert] = 'There was an issue with your comment. Please try again.'
      redirect_to recipe_path(@recipe)
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    authorize_user(@comment)
    @recipe = @comment.recipe
  end

  def update
    @comment = Comment.find(params[:id])
    authorize_user(@comment)
    @recipe = @comment.recipe

    if @comment.update(comment_params)
      flash[:notice] = 'Your comment was successfully updated.'
      redirect_to recipe_path(@recipe)
    else
      flash.now[:alert] = 'There was an issue with your comment. Please try again.'
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize_user(@comment)
    @recipe = @comment.recipe
    @comment.destroy
    flash[:notice] = 'Your comment was successfully deleted.'
    redirect_to recipe_path(@recipe)
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :body, :recipe)
  end

  def authorize_user(comment)
    unless user_signed_in? and (comment.user == current_user)
      raise ActionController::RoutingError.new('The page you requested was not found.')
    end
  end
end

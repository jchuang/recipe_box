class CommentsController < ApplicationController

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.new(comment_params)
    @comment.recipe = @recipe

    if @comment.save
      redirect_to recipe_path(@recipe),
        notice: 'Your comment was successfully added.'
    else
      redirect_to recipe_path(@recipe),
        notice: 'There was an issue with your comment. Please try again.'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @recipe = @comment.recipe
  end

  def update
    @comment = Comment.find(params[:id])
    @recipe = @comment.recipe

    if @comment.update(comment_params)
      redirect_to recipe_path(@recipe), notice: 'Your comment was successfully updated.'
    else
      render :edit, notice: 'There was an issue with your comment. Please try again.'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @recipe = @comment.recipe
    @comment.destroy
    redirect_to recipe_path(@recipe), notice: 'Your comment was successfully deleted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :body, :recipe)
  end

end

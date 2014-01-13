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

  private

  def comment_params
    params.require(:comment).permit(:title, :body, :recipe)
  end

end

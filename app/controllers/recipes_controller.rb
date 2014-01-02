class RecipesController < ApplicationController

  def new
    @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to recipe_path(@recipe), notice: 'Recipe was successfully added.'
    else
      render :new
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :time_in_minutes, :servings,
      :ingredients, :directions, :notes, :visibility)
  end

end

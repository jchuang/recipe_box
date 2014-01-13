class RecipesController < ApplicationController

  def new
    @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.find(params[:id])
    @comments = @recipe.comments
    @comment = Comment.new
  end

  def index
    @recipes = filter_recipes(params)
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to recipe_path(@recipe), notice: 'Recipe was successfully added.'
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: 'Recipe was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, notice: 'Recipe was successfully deleted.'
  end

  private

  def filter_recipes(params)
    recipes = Recipe.all
    if params[:minutes].present?
      recipes = recipes.maximum_time(params[:minutes].to_i)
    end
    if params[:keywords].present?
      recipes = recipes.search_text(params[:keywords])
    end
    recipes
  end

  def recipe_params
    params.require(:recipe).permit(:name, :time_number, :time_unit, :servings,
      :ingredients, :directions, :notes, :visibility)
  end

end

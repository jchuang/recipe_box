class RecipesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:show, :index]

  def new
    @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.find(params[:id])
    @comments = @recipe.comments.order(:created_at)
    @comment = Comment.new
  end

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @recipes = Recipe.where(user_id: params[:user_id]).filter_recipes(params)
    else
      @recipes = Recipe.filter_recipes(params)
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      redirect_to recipe_path(@recipe), notice: 'Recipe was successfully added.'
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    authorize_user(@recipe)
  end

  def update
    @recipe = Recipe.find(params[:id])
    authorize_user(@recipe)

    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: 'Recipe was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    authorize_user(@recipe)

    @recipe.destroy
    redirect_to recipes_path, notice: 'Recipe was successfully deleted.'
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :time_number, :time_unit, :servings,
      :ingredients, :directions, :notes, :visibility, tag_ids: [])
  end

  def authorize_user(recipe)
    unless user_signed_in? and (recipe.user == current_user)
      raise ActionController::RoutingError.new('The page you requested was not found.')
    end
  end
end

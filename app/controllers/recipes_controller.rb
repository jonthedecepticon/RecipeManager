class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :create, :edit, :update]

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:success] = "Your recipe was saved succesfully!"
      redirect_to recipes_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was succesfully updated!"
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  private
    def find_recipe
      @recipe = Recipe.find(params[:id])
    end

    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description)
    end
end

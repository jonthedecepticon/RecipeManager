class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :like]

  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 2)
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.find(2)
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

  def like
    like = Like.create(like: params[:like], chef: Chef.first, recipe: @recipe)
    if like.valid?
      flash[:success] = "You have liked this recipe!"
    else
      flash[:danger] = "Sorry, only one vote per recipe!"
    end
    redirect_to :back
  end

  private
    def find_recipe
      @recipe = Recipe.find(params[:id])
    end

    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end
end

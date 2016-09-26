class ChefsController < ApplicationController
  before_action :find_chef, only: [:edit, :update, :show]
  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 5)
  end

  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)

    if @chef.save
      flash[:success] = "Your account has been created succesfully!"
      redirect_to recipes_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @chef.update(chef_params)
      flash[:success] = "Your profile has been updated succesfully!"
      redirect_to recipes_path #TODO change to chef show page
    else
      render 'edit'
    end
  end

  def show
    @recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
  end

  def destroy
  end

  private
    def find_chef
      @chef = Chef.find(params[:id])
    end

    def chef_params
      params.require(:chef).permit(:chefname, :email, :password)
    end
end

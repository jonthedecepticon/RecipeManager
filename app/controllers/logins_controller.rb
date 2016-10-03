class LoginsController < ApplicationController
  def new
  end

  def create
    chef = Chef.find_by(email: params[:email])
    if chef && chef.authenticate(params[:password])
      session[:chef_id] = chef.id
      flash[:success] = "Successfully signed in. Welcome #{chef.chefname}"
      redirect_to recipes_path
    else
      flash.now[:danger] = "Incorrect email or password."
      render 'new'
    end
  end

  def destroy
    session[:chef_id] = nil
    flash[:success] = "You have successfully been signed out."
    redirect_to root_path
  end

end

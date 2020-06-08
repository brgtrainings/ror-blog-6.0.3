class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "User logged in successfully."
      redirect_to user
    else
      flash.now[:alert] = "Failed to log in."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "User logged out successfully."
    redirect_to root_path
  end
end

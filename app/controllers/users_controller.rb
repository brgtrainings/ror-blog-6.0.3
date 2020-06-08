class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @posts = @user.posts.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to BRG Blog #{@user.username}, you have successfully sign up."
      redirect_to posts_path
    else
      flash[:alert] = 'Failed to create user.'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "#{@user.username} updated successfully."
      redirect_to @user
    else
      flash[:alert] = 'Failed to edit user.'
      render 'edit'
    end
  end

  def destroy
    @user.delete
    session[:user_id] = nil
    flash[:notice] = "#{@user.username} deleted successfully."
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :password)
  end

  def require_same_user
    if current_user != @user
      flash[:alert] = "You can only edit your own user."
      redirect_to @user
    end
  end
end

class UsersController < ApplicationController
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:notice] = "Welcome to BRG Blog #{@user.username}, you have successfully sign up."
      redirect_to posts_path
    else
      flash[:alert] = 'Failed to create user.'
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "#{@user.username} successfully updated."
      redirect_to @user
    else
      flash[:alert] = 'Failed to edit user.'
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :password)
  end
end

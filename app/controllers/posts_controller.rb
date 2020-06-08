class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = 'Post was created successfully.'
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @post.update(post_params)

    if @post.save
      flash[:notice] = 'Post was updated successfully.'
      redirect_to @post
    else
      flash[:alert] = 'Something went wrong.'
      render 'edit'
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = 'Post was deleted successfully.'
    else
      flash[:alert] = 'Something went wrong.'
    end

    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description)
  end

  def require_same_user
    if current_user != @post.user
      flash[:alert] = "You can only edit or delete your own post."
      redirect_to @post
    end
  end
end

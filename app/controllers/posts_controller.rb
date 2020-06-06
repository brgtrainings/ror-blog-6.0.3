class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = 'Post was created successfully.'
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
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
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = 'Post was deleted successfully.'
    else
      flash[:alert] = 'Something went wrong.'
    end

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :description)
  end
end

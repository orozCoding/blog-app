class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.new(post_params)
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to user_posts_path(@user), success: 'Post created!' }
      else
        format.html { redirect_to user_posts_path(@user), danger: 'Someting went wrong!' }
      end
    end
  end

  private

  def post_params
    post_hash = params.require(:post).permit(:title, :text)
    post_hash[:author] = User.find(params[:user_id])
    post_hash
  end
end

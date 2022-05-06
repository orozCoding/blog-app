class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @like = Like.new(author: current_user, post: @post)

    respond_to do |format|
      if @like.save
        format.html { redirect_to user_post_path(@user, @post), success: 'You liked the post!' }
      else
        format.html { redirect_to user_post_path(@user, @post), danger: 'Something went wrong!' }
      end
    end
  end
end

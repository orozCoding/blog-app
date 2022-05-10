class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @user = User.find(params[:user_id])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to user_post_path(@user, @post), success: 'comment created!' }
      else
        format.html { redirect_to user_post_path(@user, @post), danger: 'something went wrong!' }
      end
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.decrement_comments_counter
    redirect_to user_post_path(@user, @post)
    flash[:notice] = 'Comment destroyed'
    @comment.destroy
  end

  private

  def comment_params
    comment_hash = params.require(:comment).permit(:text)
    comment_hash[:author] = current_user
    comment_hash[:post] = Post.find(params[:post_id])
    comment_hash
  end
end

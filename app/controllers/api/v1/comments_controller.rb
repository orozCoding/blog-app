class Api::V1::CommentsController < Api::V1::BaseController
  before_action :authorize_request

  def index
    @comments = Comment.where(post_id: params[:post_id])
    render json: @comments
  end

  def create
    user_id = current_user.id
    text = params[:text]
    post_id = params[:post_id]

    @comment = Comment.new(author_id: user_id, post_id: post_id, text: text)

    if @comment.save
      render json: @comment, status: 201
    else
      render json: "Comment is not created! User with id #{params[:user_id]} is not authorized to create comments!",
             status: 401
    end
  end

  # def comment_params
  #   comment_hash = params.require(:comment).permit(:text)
  #   comment_hash[:author] = current_user.id
  #   comment_hash[:post] = Post.find(params[:post_id])
  #   comment_hash
  # end
end

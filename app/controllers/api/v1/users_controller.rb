class Api::V1::UsersController < Api::V1::BaseController
  before_action :authorize_request

  def index
    render json: User.all
  end

  def show
    @user = User.find(params[:id])

    render json: @user, status: 200
  end
end

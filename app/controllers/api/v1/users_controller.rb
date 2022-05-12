class Api::V1::UsersController < Api::V1::BaseController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]

  # def login
  #   @user = User.find_by_email(params[:email])
  #   if @user&.authenticate(params[:password])
  #     token = JsonWebToken.encode(user_id: @user.id)
  #     time = Time.now + 24.hours.to_i
  #     render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
  #                    username: @user.username }, status: :ok
  #   else
  #     render json: { error: 'unauthorized' }, status: :unauthorized
  #   end
  # end

  def index
    render json: User.all
  end

  def show
    @user = User.find(params[:id])

    render json: @user, status: 200
  end
end

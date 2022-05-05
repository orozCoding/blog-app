class UsersController < ApplicationController
  def index
    @users_list = User.all
  end

  def show
    @user = User.find(params[:user_id])
  end
end

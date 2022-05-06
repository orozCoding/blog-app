class UsersController < ApplicationController
  def index
    @users_list = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end

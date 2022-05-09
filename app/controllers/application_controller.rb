class ApplicationController < ActionController::Base
  add_flash_types :danger, :info, :warning, :success, :messages

  # def current_user
  #   User.first
  # end

  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :username, :photo, :bio, :email, :password)}
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :username, :email, :password, :current_password)}
  end
end

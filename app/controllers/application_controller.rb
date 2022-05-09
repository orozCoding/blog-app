class ApplicationController < ActionController::Base
  add_flash_types :danger, :info, :warning, :success, :messages

  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :username, :email, :photo, :bio, :password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :username, :photo, :bio, :email, :password, :current_password)}
  end
end

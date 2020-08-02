class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(user)
    flash[:notice] = "Привет, #{user.first_name}"
    user.admin? ? admin_tests_path : root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
end

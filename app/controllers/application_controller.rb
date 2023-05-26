class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_user_is_login, if: :required_login?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  def required_login?
    params[:controller] != 'home' && !devise_controller? && !params[:controller].match?('active_admin/.*') && !params[:controller].match?('admin/.*')
  end

  def check_user_is_login
    return if user_signed_in?

    redirect_to new_user_session_path
  end
end

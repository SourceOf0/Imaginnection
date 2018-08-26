class ApplicationController < ActionController::Base
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  # deviseでのログイン認証
  before_action :authenticate_user!
  
  # deviseのstring parameter
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  
  # deviseのstring parameter
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :empathy_button_kind, :is_disable_follow, :is_hide_edges])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :empathy_button_kind, :is_disable_follow, :is_hide_edges])
  end

end

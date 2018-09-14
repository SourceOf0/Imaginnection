class ApplicationController < ActionController::Base
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :site_http_basic_authenticate_with if ENV['USE_BASIC'] == 'true'

  # deviseでのログイン認証
  before_action :authenticate_user!
  
  # deviseのstring parameter
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログ用
  before_action :print_info

  def set_logger( name, text )
    logger.info 'LOG[ ' + name + ' ] ' + text
  end
  
  def site_http_basic_authenticate_with
    authenticate_or_request_with_http_basic("Application") do |name, password|
      name == ENV['BASIC_USERNAME'] && password == ENV['BASIC_PASSWORD']
    end
  end
  
  def print_info
    if user_signed_in?
      set_logger( 'login user accessed -> ' + request.path, current_user.name + ' : ' + current_user.ref_id )
    else
      set_logger( 'guest user accessed', '' )
    end
  end

  protected
  
  # deviseのstring parameter
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :empathy_button_kind, :is_disable_follow, :is_hide_edges])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :empathy_button_kind, :is_disable_follow, :is_hide_edges])
  end

end

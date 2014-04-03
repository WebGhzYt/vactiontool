class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_session_before_authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  #before_filter :check_access, unless: :devise_controller?

  before_filter :authenticate_user!

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
                                                              :password,
                                                              :password_confirmation,
                                                              :email,
                                                              :provider,
                                                              :uid,
                                                              :name) }
  end
  
  # def check_access
  #   unless current_user.has_access
  #     redirect_to root_path
  #   end
  # end

  def set_session_before_authenticate_user!
    logger.debug params
    unless params[:return_to].nil?
      session[:return_to] = request.url
      logger.debug request.url
    end
    authenticate_user!
  end

end




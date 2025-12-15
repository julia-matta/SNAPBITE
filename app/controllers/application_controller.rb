class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  private


  #MÉTODO DEVOLVER PARA PÁGINA DE LOGIN APÓS LOGOUT
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def user_not_authorized
    flash[:alert] = "Você não tem permissão para fazer isso."
    redirect_to(request.referer || root_path)
  end

  def after_sign_in_path_for(_resource)
    root_path
    # ou, se preferir:
    # restaurants_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username role])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username role])
  end
end

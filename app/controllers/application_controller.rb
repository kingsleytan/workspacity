class ApplicationController <ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  include Pundit


  rescue_from Pundit::NotAuthorizedError do |exception|
    flash[:danger] = "You're not authorized"
    # changed root_path to '/' because of routing error caused by rails_admin
    redirect_to request.referrer || '/'
  end

  private

  def resource_name
    :user
  end
  helper_method :resource_name


  def resource
    @resource ||= User.new
  end
  helper_method :resource

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  helper_method :devise_mapping

  def resource_class
    User
  end
  helper_method :resource_class


  # def authenticate!
  # unless current_user
  #   redirect_to root_path
  #   flash[:danger] = "You need to login first"
  # end
  # end
  #

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

end

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
end

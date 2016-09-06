class ApplicationController <ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  include Pundit


  rescue_from Pundit::NotAuthorizedError do |exception|
   flash[:danger] = "You're not authorized"
   redirect_to request.referrer || root_path
 end

  # private


  # def current_user
  #   return unless session[:id]
  #   @current_user ||= User.find_by(id: session[:id])
  # end
  # helper_method :current_user

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def auth_user
    redirect_to landing_path unless user_signed_in?
  end

  def current_user_subscribed?
    user_signed_in? && current_user.subscribed?
  end
  helper_method :current_user_subscribed?

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to landing_path
    end
  end

end

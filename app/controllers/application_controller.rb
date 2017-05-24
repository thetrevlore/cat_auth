class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    #debugger
    #@current_user = User.find_by(session_token: @user.session_token)
    @current_user ||= User.find_by(session_token: session[:session_token])

  end

  def login(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user
    "s"
  end

  def logged_in?
    !!current_user
  end

  # def redirect_unless_logged_in
  #   redirect_to new_session_url unless logged_in?
  # end

  def redirect_if_logged_in
    redirect_to cats_url if logged_in?
  end
end

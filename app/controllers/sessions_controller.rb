class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:create, :new]

  def new
    #@user = User.new
    render :new
  end

  def create
    #check if user exits
    #check pw is right
    #if okay login
    #else throw errors

    @user = User.find_by_credentials(session_params[:username], session_params[:password])

    if @user
      login(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = ["login failed"]
      render :new
    end


  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
    end
    redirect_to cats_url
  end

  def session_params
    params.require(:user).permit(:username, :password)
  end

end

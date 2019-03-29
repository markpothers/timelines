class SessionsController < ApplicationController

   skip_before_action :authenticate, :only => [:new, :create]
   skip_before_action :verify_authenticity_token, only: :destroy

  def new
  end

  def create
    if session_params[:username] == "" || session_params[:password] == ""
      redirect_to '/'
    else
      @user = User.find_by(username: session_params[:username])
      if @user != nil
        return head(:forbidden) unless @user.authenticate(session_params[:password])
        session[:user_id] = @user.id
        session[:username] = @user.username
        redirect_to "/users/#{@user.id}"
      else
        redirect_to '/'
      end
    end
  end

  def destroy
    reset_session
    redirect_to '/'
  end

  private

  def session_params
      params.require(:user).permit(:password, :username)
  end

end
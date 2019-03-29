class UsersController < ApplicationController

   skip_before_action :authenticate, :only => [:new, :create]

  def new
  end

  def create
      if user_params[:password] == user_params[:password_confirmation]
          @user = User.create(user_params)
          session[:user_id] = @user.id
          session[:username] = @user.username
          redirect_to "/users/#{@user.id}"
      else
          redirect_to '/users/new'
      end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation)
  end
end
class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'You have successfully logged in'
      redirect_to user_path(user)
    else
      flash.now[:danger] = 'There was something wrong with your login information'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end
end
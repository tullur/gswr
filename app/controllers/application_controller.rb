# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def require_user
    unless logged_in?
      flash[:danger] = 'You must be logged in to perform that action'
      redirect_to root_path
    end
  end
end

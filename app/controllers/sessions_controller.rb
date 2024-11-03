class SessionsController < ApplicationController
  def new
    # Render login form
  end

  def create
    if params[:username].present?
      session[:username] = params[:username]
      redirect_to root_path, notice: "Logged in as #{params[:username]}"
    else
      flash.now[:alert] = "Username can't be blank"
      render :new
    end
  end

  def destroy
    session.delete(:username)
    redirect_to login_path, notice: "Logged out"
  end
end


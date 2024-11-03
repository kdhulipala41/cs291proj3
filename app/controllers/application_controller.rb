class ApplicationController < ActionController::Base
  before_action :require_login


  def handle_invalid_url
    if current_user
      # Render a 404 page if the user is logged in
      render file: "#{Rails.root}/public/404.html", status: :not_found
    else
      # Redirect to /login if the user is not logged in
      redirect_to login_path, alert: "Please log in to access this page."
    end
  end

  def require_login
    unless session[:username].present? || (controller_name == "sessions" && action_name.in?(%w[new create]))
      redirect_to login_path
    end
  end

  def current_user
    session[:username]
  end

  helper_method :current_user


end

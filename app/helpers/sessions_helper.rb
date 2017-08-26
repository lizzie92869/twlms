module SessionsHelper
  # Logs in given user by setting session key
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any) else null
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out given user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Page access requires logged-in user else redirects to login page
  def authenticate!
    if !logged_in?
      flash.now[:notice] = 'Page access requires you to log in'
      redirect_to new_session_path
    end
  end
end

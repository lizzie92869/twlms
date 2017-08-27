module SessionsHelper
  # Logs in given user by setting session key
  def log_in(user)
    session[:user_id] = user.id
  end

  # Remembers a user in persistent session
  def remember(user)
    user.remember
    # cookie is encrypted and expires in 20 years
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Returns the current logged-in user (if any) else null
  def current_user
    #@current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    # first check for user by session
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)

    # if no session, check for cookie with digest token
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Forgets a persistent session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out given user
  def log_out
    forget(current_user)
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

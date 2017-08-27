class SessionsController < ApplicationController

  # Login form
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user_path(user)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render :new
    end
  end

  # Only log_out if logged in else you get bugs from multiple browser sessions open
  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end

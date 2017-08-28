class SessionsController < ApplicationController

  before_action :force_no_login, only: [:new]

  # Login form
  def new
  end

  def create
    #onmiauth Login
    if !auth.nil?
      user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.email = auth['info']['email']
        # generate random password
        u.password = User.new_token
      end
      if user
        log_in user
        flash.now[:notice] = "Welcome #{user.try(:email)}"
        redirect_to root_path
      else
        redirect_to root_path
      end
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to root_path
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render :new
      end
    end
  end

  # Only log_out if logged in else you get bugs from multiple browser sessions open
  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  # Omniauth hash
  def auth
    request.env['omniauth.auth']
  end
end

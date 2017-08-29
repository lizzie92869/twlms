class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate!, except: [:new, :create]
  before_action :force_no_login, only: [:new]
  before_action :authorize_user, except: [:index, :new, :create]

  def index
    @users = User.all
    authorize @users
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #send verification email
      UserMailer.verification_email(@user).deliver_later
      #login user after creating them
      log_in @user
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "User updated sucessfully!"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :email,
      :password
    )
  end

  def authorize_user
    authorize @user
  end
end

class WeightsController < ApplicationController

  before_action :set_weight, only: [:show, :edit, :update, :destroy]
  before_action :authenticate!

  def index
    @weights = current_user.weights
  end

  def show
  end

  def new
    @weight = Weight.new(user_id: current_user.id, date: Time.now.utc)
  end

  def create
    @weight = Weight.new(weight_params)
    if @weight.save
      redirect_to weights_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @weight.update(weight_params)
      redirect_to weights_path
    else
      render :edit
    end
  end

  def destroy
    @weight.destroy if @weight
    redirect_to weights_path
  end


  private

  def set_weight
    @weight = Weight.find_by(user_id: current_user.id, id: params[:id])
  end

  def weight_params
    params.require(:weight).permit(
      :user_id,
      :amount,
      :date
    )
  end

  def authorize
    authorize @weight
  end
end

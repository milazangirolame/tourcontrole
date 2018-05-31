class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :set_booking, only:[:show, :edit, :update, :destroy]
  before_action :set_activity, only:[:new, :create]

  def index
    @bookings = policy_scope(Booking.all)
  end

  def show
  end

  def new
    @booking = Booking.new
    authorize @booking
    @booking.guests.build
  end

  def create
    @booking = Booking.new(set_params)
    @booking.activity = @activity
    if @booking.save
      redirect_to booking_order_path(@booking)
    else
      render :new
    end
  end

  def edit
    @booking.update(set_params)
    if @booking_oder.save
      redirect_to activity_path(@activity)
    else
      render :edit
    end
  end

  def destroy
    @booking.destroy
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def set_activity
    @activity = Activity.find(params[:activity_id])
    skip_authorization
  end

  def set_params
    params.require(:booking).permit(  guests_attributes: [:id, :_destroy, :first_name, :last_name, :email])
  end

end

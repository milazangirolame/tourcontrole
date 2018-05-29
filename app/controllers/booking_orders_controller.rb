class BookingOrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :set_booking_order, only:[:show, :edit, :update, :destroy]
  before_action :set_activity, only:[:new, :create]

  def index
    @booking_orders = BookingOrder.all
  end

  def show
  end

  def new
    @booking_order = BookingOrder.new
    authorize @booking_order
    @booking_order.guests.build
  end

  def create
    @booking_order = BookingOrder.new(set_params)
    @booking_order.activity = @activity
    if @booking_order.save
      redirect_to booking_order_path(@booking_order)
    else
      render :new
    end
  end

  def edit
    @booking_order.update(set_params)
    if @booking_oder.save
      redirect_to activity_path(@activity)
    else
      render :edit
    end
  end

  def destroy
    @booking_order.destroy
  end

  private

  def set_booking_order
    @booking_order = BookingOrder.find(params[:id])
    authorize @booking_order
  end

  def set_activity
    @activity = Activity.find(params[:activity_id])
    skip_authorization
  end

  def set_params
    params.require(:booking_order).permit(  guests_attributes: [:id, :_destroy, :first_name, :last_name, :email])
  end

end

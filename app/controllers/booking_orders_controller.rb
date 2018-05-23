class BookingOrdersController < ApplicationController
   before_action :set_booking_order, only:[:show, :edit, :update, :destroy]
   before_action :set_activity, only:[:new, :create]
  def index
    @booking_orders = BookingOrder.all
  end

  def show
  end

  def new
    @booking_order = BookingOrder.new
    @guest = Guest.new(booking_order: @booking_order)
  end

  def create
    @booking_order = BookingOrder.new(activity: @activity)
    if @booking_order.save
      if params[:booking_order][:guest].present?
        @guest = Guest.new(params[:booking_order][:guest])
        @guest.booking_order = @booking_order
        @guest.save
      end
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
    @booking_order = BookingOrder.find(params[:booking_order_id])
  end

  def set_activity
    @activity = Activity.find(params[:activity_id])
    authorize @activity
  end

  def set_params
    params.require(:booking_order).permit(:activity_id,:booking_order ,guest:[])
  end

end

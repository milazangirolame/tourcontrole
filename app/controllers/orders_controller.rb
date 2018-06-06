class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :new]

  before_action :set_activity, only: [:create, :new]
  before_action :set_order, only:[:show, :edit, :update, :destroy]
  before_action :set_event, only:[:new, :create]
  def new
    @order = Order.new
    booking = @order.bookings.build
    booking.event = @event
    booking.build_guest
  end

  def create
    @order = Order.new(set_params)
    @order.bookings.each {|booking| booking.event = @event}
    # @order.activity = @activity
    if @order.save
      flash[:notice] = "Resserva feita com sucesso"
      redirect_to activity_path(@activity)
    else
      flash[:alert] = "Campos incompletos. Aceitou os termos de Serviço? Verifique e tente novamente"
      @order = Order.new
      booking = @order.bookings.build
      booking.event = @event
      booking.build_guest
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def index
  end

  private

  def set_order
    @order = Order.find(params[:id])
    # authorize @order
  end

  def set_activity
    @activity = Activity.find(params[:activity_id])
    skip_authorization
  end

  def set_params
    params.require(:order).permit( :order_total,
    bookings_attributes: [ :id, :_destroy, :guest_id,
    guest_attributes: [ :id, :_destroy, :first_name, :last_name, :email ]])
  end

  def set_event
    selected_date = params[:date]
    @event = @activity.events.find_by(starts_at: selected_date) || Event.create(starts_at: selected_date, activity: @activity)
  end
end

class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create, :new]
  before_action :set_activity, only: [ :create, :new]
  before_action :set_order, only: [ :show, :edit, :update, :destroy]
  before_action :set_event, only: [ :new, :create]
  def new
    @order = Order.new
    @order.build_payment
  end

  def create
    @order = Order.new(set_params)
    @order.bookings.each {|booking| booking.event = @event}
    if @order.save
      set_buyer_guest
      create_moip_customer
      create_moip_order
      flash[:notice] = "Resserva feita com sucesso"
      redirect_to activity_path(@activity)
    else
      if @order.errors.any?
        flash[:alert] = @order.errors.messages.first.second.first
      end
      @order = Order.new
      @order.build_payment
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def create_moip_order
    @moip.create_order(@order)
  end

  def create_moip_customer
    @moip.create_customer(@order)
  end

  def index
  end

  private

  def set_order
    @order = Order.find(params[:id])
    # authorize @order
  end

  def set_activity
    @activity = Activity.find_by_slug(params[:activity_slug])
    skip_authorization
  end

  def set_params
    params.require(:order).permit( :order_total,
    bookings_attributes: [ :id, :_destroy, :guest_id,
    guest_attributes: [ :id, :_destroy, :first_name, :last_name, :email ]],
    payment_attributes: [:token, :name, :exp, :ccv, :number, :cpf, :email, :street,
        :street_number, :city, :district, :state, :country, :postal_code,
        :phone_country_code, :phone_area_code, :phone_number])
  end

  def set_event
    selected_date = params[:date]
    @event = @activity.events.find_by(start_day: selected_date.to_date) || Event.create(start_day: selected_date.to_date, activity: @activity)
  end

  def set_buyer_guest
    guest = Guest.new(first_name: @order.payment.name.split(' ').first,
      last_name: @order.payment.name.split(' ').last, email: @order.payment.email,
      buyer: true)
    @order.bookings.create(guest: guest, event: @event)
  end
end

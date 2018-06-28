class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create, :new]
  before_action :set_activity, :set_tour_store_via_activity, only: [ :create, :new]
  before_action :set_tour_store, only: [ :show, :edit, :update, :destroy]
  before_action :set_order, only: [ :show, :edit, :update, :destroy]
  before_action :set_event, only: [ :new, :create]
  def new
    @order = Order.new
    authorize @order
    @order.build_payment
    @public_key = @activity.tour_store.public_key
  end

  def create
    @hash = set_params[:encrypted_data]
    @order = Order.new(set_params)
    authorize @order
    @order.bookings.each {|booking| booking.event = @event}
    if @order.save
      set_buyer_guest
      create_moip_customer
      create_moip_order
      create_moip_payment
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
    MoipApi.new(@tour_store).create_order(@order)
  end


  def create_moip_customer
    MoipApi.new(@tour_store).create_customer(@order)
  end

  def create_moip_payment
    MoipApi.new(@tour_store).create_payment(@order, @hash)
  end

  def index
  end

  private

  def set_order
    @order = Order.find(params[:id])
    authorize @order
  end

  def set_activity
    @activity = Activity.find_by_slug(params[:activity_slug])
    skip_authorization
  end

  def set_tour_store_via_activity
    @tour_store = @activity.tour_store
  end

  def set_tour_store
    @tour_store = TourStore.find_by_slug(params[:tour_store_slug])
  end

  def set_params
    params.require(:order).permit( :order_total, :encrypted_data,
    bookings_attributes: [ :id, :_destroy, :guest_id,
    guest_attributes: [ :id, :_destroy, :first_name, :last_name, :email ]],
    payment_attributes: [:installments, :name, :exp, :ccv, :number, :cpf, :email, :street,
        :street_number, :city, :district, :state, :country, :postal_code,
        :phone_country_code, :phone_area_code, :phone_number])
  end

  def set_event
    selected_date = params[:date]
    @event = @activity.events.find_by(start_day: selected_date.to_date) || Event.create(start_day: selected_date.to_date, activity: @activity)
    authorize @event
  end

  def set_buyer_guest
    guest = Guest.new(first_name: @order.payment.name.split(' ').first,
      last_name: @order.payment.name.split(' ').last, email: @order.payment.email,
      buyer: true, phone: @order.payment.phone)
    @order.bookings.create(guest: guest, event: @event)
  end

end

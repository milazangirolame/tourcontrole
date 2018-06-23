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
      create_moip_buyer
      create_moip_order
      flash[:notice] = "Resserva feita com sucesso"
      redirect_to activity_path(@activity)
    else
      if @order.errors.any?
        flash[:alert] = @order.errors.messages.first.second.first
      end
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

  def create_moip_order
    new_moip_order(@order)
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

  def new_moip_order(sales_order)
    moip_order = @api.order.create(
      ownId: sales_order.id,
      amount: {
        currency: 'BRL',
        subtotals: {
          shipping: 0
        }
      },
      items: [
        {
          product: sales_order.events.first.activity.name,
          category: 'OTHER_CATEGORIES',
          quantity: sales_order.bookings.count,
          detail: sales_order.events.first.activity.description,
          price: sales_order.events.first.price.to_i
        }
      ],
      customer: {
        id: sales_order.buyer.moip_id
      },
      receivers: [
        {
          type: 'SECONDARY',
          feePayor: false,
          moipAccount: {
            id: sales_order.events.first.activity.tour_store.moip_id
          },
          amount: {
            percetual: 90
          }
        },
        {
          type: 'PRIMARY',
          feePayor: true,
          moipAccount: {
            id: "APP-ECV6553RNHOR"
          },
          amount: {
            percetual: 10
          }
        }
      ]
    )
    sales_order.update(moip_id: moip_order[:id], status: moip_order[:status])
  end


  def set_buyer_guest
    guest = Guest.new(first_name: @order.payment.name.split(' ').first,
      last_name: @order.payment.name.split(' ').last, email: @order.payment.email,
      buyer: true)
    @order.bookings.create(guest: guest, event: @event)
  end

  def create_moip_buyer
    buyer = @order.buyer
    payment = @order.payment
    customer = @api.customer.create(
      ownId: buyer.id,
      fullname: buyer.full_name,
      email: buyer.email,
      phone: {
        areaCode: payment.phone_area_code,
        number: payment.phone_number,
      },
      birthDate: "1990-10-22",
      taxDocument: {
        type: "CPF",
        number: payment.cpf,
      },
      shippingAddress: {
        street: payment.street,
        streetNumber: payment.street_number,
        complement: "",
        district: payment.district,
        city: payment.city,
        state: payment.state,
        country: "BRA",
        zipCode: payment.postal_code,
      },
    )
    buyer.update(moip_id: customer[:id])
  end
end

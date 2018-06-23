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
    @order.build_payment
  end

  def create
    @order = Order.new(set_params)
    @order.bookings.each {|booking| booking.event = @event}
    # @order.activity = @activity
    if @order.save
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
    payment_attributes: [:token, :name, :exp, :ccv, :number])
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
      # customer: {
      #   id: 'CUS-87HFA3QCEKO7'
      # },
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
    sales_order.update(moip_id: moip_order[:id], stauts: moip_order[:status])
  end

end

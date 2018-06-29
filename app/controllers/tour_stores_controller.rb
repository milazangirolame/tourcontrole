class TourStoresController < ApplicationController
  before_action :set_tour_store, only: [:edit, :update, :show, :destroy]
  before_action :set_current_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_tour_store_data_sources, only: [:dashboard, :tours, :users, :events, :company, :bank]

  def index
    @tour_stores = policy_scope(TourStore)
  end

  def new
    @tour_store = TourStore.new
    authorize @tour_store
  end

  def create
    @tour_store = TourStore.new(set_params)
    authorize @tour_store
    @tour_store.user = current_user
    if @tour_store.save
      create_moip_account
      tour_store_admin = TourStoreAdmin.new(user: current_user, tour_store: @tour_store)
      tour_store_admin.store_creator = true
      tour_store_admin.save
      redirect_to tour_store_path(@tour_store)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @tour_store.update(set_params)
    if @tour_store.save
      redirect_to tour_store_path(@tour_store)
    else
      render :edit
    end
  end

  def show
    @activities = policy_scope(Activity).where(tour_store: @tour_store)
  end

  def destroy
    @tour_store.destroy
  end

  def dashboard
  end

  def events
    @upcoming_events = @tour_store.events.order(start_day: :asc).select{ |event| event.spots_taken > 0 && event.start_day >= Date.today}
  end

  def tours
  end

  def bank
    @transfer = Transfer.new(tour_store: @tour_store)
  end

  def users
    @tour_store_admin = TourStoreAdmin.new(tour_store:@tour_store)
  end

  def company
  end

  def create_moip_account
    @moip.create_store(@tour_store)
  end

  private

  def set_params
    params.require(:tour_store).permit(:form_address, :phone, :website, :name, :description,
                                      :business_tax_id, :regulator_id, :logo, :legal_representant_id, :user_id,
                                       :photo, :photo_cache, :image_banner, :instagram_link,
                                       :trip_advisor_link, :facebook_link, :twitter_link,
                                       banking_information_attributes:[
                                        :bank, :bank_ag, :bank_cc, :account_type])
  end

  def set_tour_store
    @tour_store = TourStore.find_by_slug(params[:slug])
    authorize @tour_store
  end

  def set_current_user
    @user = current_user
  end

  def set_tour_store_data_sources
    @tour_store = TourStore.find_by_slug(params[:tour_store_slug])
    authorize @tour_store
    @activities = policy_scope(Activity).where(tour_store: @tour_store)
    @activity = Activity.new
    @banking_information = @tour_store.banking_information
  end


end

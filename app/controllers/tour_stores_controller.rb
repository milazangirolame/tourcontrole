class TourStoresController < ApplicationController
  before_action :set_tour_store, only: [:edit, :update, :show, :destroy]
  before_action :set_current_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_tour_store_data_sources, only: [:dashboard, :tours, :users]
  def index
    @tour_stores = policy_scope(TourStore)
  end


  def new
    @tour_store = TourStore.new
    authorize @tour_store
  end

  def create
    @tour_store = TourStore.new(set_params)
    @tour_store.user = current_user
    if @tour_store.save
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
    @activities = @tour_store.activities.order(start_date: :desc)
  end

  def destroy
    @tour_store.destroy
  end

  def dashboard
  end


  def tours
  end

  def users
  end


  private

  def set_params
    params.require(:tour_store).permit(:address, :phone, :website, :name, :description,
                                      :business_tax_id, :regulator_id, :logo, :user_id, :photo, :photo_cache)
  end

  def set_tour_store
    @tour_store = TourStore.find(params[:id])
    authorize @tour_store
  end

  def set_current_user
    @user = current_user
  end


  def set_tour_store_data_sources
    @tour_store = TourStore.find(params[:tour_store_id])
    authorize @tour_store
    @activities = policy_scope(Activity).where(tour_store: @tour_store)
    @activity = Activity.new
  end
end

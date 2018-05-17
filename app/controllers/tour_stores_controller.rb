class TourStoresController < ApplicationController
  before_action :set_tour_store, only: [:edit, :update, :show, :destroy, :dashboard]
  def index
    @tour_stores = TourStore.all.order(created_at: :desc)
  end


  def new
    @tour_store = TourStore.new
  end

  def create
    @tour_store = TourStore.new(set_params)
    @tour_store.user = current_user
    if @tour_store.save
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
    @activities = @tour_store.activities.order(created_at: :desc)
  end

  def destroy
    @tour_store.destroy
  end

  def dashboard
    @activities = @tour_store.activities.order(created_at: :desc)
    @activity = Activity.new
  end


  private

  def set_params
    params.require(:tour_store).permit(:address, :phone, :website, :name, :description,
                                      :business_tax_id, :regulator_id, :logo, :user_id, :photo, :photo_cache)
  end

  def set_tour_store
    @tour_store = TourStore.find(params[:id])
  end

end

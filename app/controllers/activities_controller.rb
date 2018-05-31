class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  before_action :set_tour_store, only: [:new, :create]
  before_action :set_activity_data_source, only: [:audit]

  def index
    @activites = policy_scope(Activity)
  end

  def new
    @activity = Activity.new
    @activity.tour_store = @tour_store
    authorize @activity
  end

  def create
    @activity = Activity.new(set_params)

    @activity.tour_store = @tour_store
    if @activity.save
      unless params[:activity][:photos].nil?
        params[:activity][:photos].each do |photo|
          @photo = @activity.photos.create!(image: photo)
        end
      end
      redirect_to tour_store_tours_path(@tour_store)
    else
      render :new
    end
  end

  def edit
    @tour_store = @activity.tour_store
  end

  def update
    @tour_store = @activity.tour_store

    @activity.update(set_params)
    if @activity.save
      redirect_to tour_store_tours_path(@tour_store)
          else
      render :edit
    end
  end

  def show
  end

  def destroy
    @activity.destroy
    redirect_to tour_stores_path
  end

  def audit
  end

  private

  def set_params
    params.require(:activity).permit(:name, :description, :price, :max_spots, :departure_location,
                              :starts_at, :ends_at, :recurring, :tour_store_id, photos:[])
  end

  def set_activity
    @activity = Activity.find(params[:id])
    authorize @activity
  end

  def set_tour_store
    @tour_store = TourStore.find(params[:tour_store_id])
    authorize @tour_store
  end

  def set_activity_data_source
    @tour_store = TourStore.find(params[:tour_store_id])
    @activity = Activity.find(params[:activity_id])
    authorize @activity
  end
end

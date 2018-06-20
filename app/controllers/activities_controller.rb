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
      # flash[:alert] = @activity.errors
      redirect_back fallback_location: tour_store_tours_path(@tour_store)
    end
  end

  def edit
    @tour_store = @activity.tour_store
  end

  def update
    @tour_store = @activity.tour_store
    @activity.update(set_params)
    if @activity.save
      unless params[:activity][:photos].nil?
        params[:activity][:photos].each do |photo|
          @photo = @activity.photos.create!(image: photo)
        end
      end
      flash[:notice] = "O Tour: #{@activity.name} foi editado com sucesso"
      redirect_to tour_store_tours_path(@tour_store)
      else
      render :edit
    end
  end

  def show
    @activity_dates = @activity.calendar_events(params.fetch(:start_date, Time.zone.now).to_date)
    @markers = [{ lat: @activity.latitude, lng: @activity.longitude }]
  end

  def destroy
    @activity.destroy
    if @activity.destroy
      flash[:notice] = "#{@activity.name} Tour excluido com sucesso"
      redirect_back fallback_location: tour_store_tours_path(@activity.tour_store)
    end
  end


  def audit
  end

  private

  def set_params
    params.require(:activity).permit(:name, :description, :price, :recurring, :max_spots, :departure_location,
                              :starts_at, :ends_at, :tour_store_slug)
  end

  def set_activity
    @activity = Activity.find_by_slug(params[:slug])
    authorize @activity
  end

  def set_tour_store
    @tour_store = TourStore.find_by_slug(params[:tour_store_slug])
    authorize @tour_store
  end

  def set_activity_data_source
    @tour_store = TourStore.find_by_slug(params[:tour_store_slug])
    @activity = Activity.find_by_slug(params[:activity_slug])
    authorize @activity
    @events = @activity.events.order(start_day: :asc)
  end
end

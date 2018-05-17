class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  before_action :set_tour_store, only: [:new, :create]

  def index
    @activites = Activity.all.prder(created_at: :desc)
  end


  def new
    @activity = Activity.new
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
      redirect_to activity_path(@activity)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @activity.update(set_params)
    if @activity.save
      redirect_to activity_path(@activity)
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

  private

  def set_params
    params.require(:activity).permit(:name, :description, :max_spots, :departure_location,
                              :date, :price, :tour_store_id)
  end

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def set_tour_store
    @tour_store = TourStore.find(params[:tour_store_id])
  end

end

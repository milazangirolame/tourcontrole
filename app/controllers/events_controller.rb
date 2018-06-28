class EventsController < ApplicationController

  def show
    @event = Event.find(params[:id])
    @tour_store = TourStore.find_by_slug(params[:tour_store_slug])
  end
end

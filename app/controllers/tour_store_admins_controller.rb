class TourStoreAdminsController < ApplicationController
  before_action :set_tour_store, only: [:create]
  def create
    email = set_params[:email]
    user = User.find_by(email: email)
    user ? user : user = User.create(email: email)
    @tour_store_admin = TourStoreAdmin.create(user: user, tour_store: @tour_store)
    if @tour_store_admin.save
      flash[:notice] = "Usuário Admin criado com sucesso"
      redirect_back fallback_location: tour_store_users_path(@tour_store)
      else
      flash[:alert] = @tour_store_admin.errors
      redirect_back fallback_location: tour_store_users_path(@tour_store)
    end
  end

  def update
  end

  def destroy
  end

  private

  def set_tour_store
    @tour_store = TourStore.find(params[:tour_store_id])
    skip_authorization
  end

  def set_params
    params.require(:tour_store_admin).permit(:email)
  end

end

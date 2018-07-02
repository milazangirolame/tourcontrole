class TourStoreAdminsController < ApplicationController
  before_action :set_tour_store, only: [:create]
  def create
    email = set_params[:email]
    user = User.find_by(email: email)
    user ? user : user = User.create(email: email)
    @tour_store_admin = TourStoreAdmin.create(user: user, tour_store: @tour_store, manager: set_params[:manager])
    authorize @tour_store_admin
    if @tour_store_admin.save
      flash[:notice] = "Usuário Admin criado com sucesso"
      redirect_back fallback_location: tour_store_company_path(@tour_store)
      else
      flash[:alert] = @tour_store_admin.errors.first
      redirect_back fallback_location: tour_store_company_path(@tour_store)
    end
  end

  def update
  end

  def destroy
    @tour_store_admin = TourStoreAdmin.find(params[:id])
    authorize @tour_store_admin
    @tour_store_admin.destroy
    if @tour_store_admin.destroy
      flash[:notice] = "Usuário excluido  com sucesso"
      redirect_back fallback_location: tour_store_company_path(@tour_store_admin.tour_store)
    else
      flash[:alert] = @tour_store_admin.errors.first
      redirect_back fallback_location: tour_store_company_path(@tour_store_admin.tour_store)
    end
  end

  private

  def set_tour_store
    @tour_store = TourStore.find_by_slug(params[:tour_store_slug])
    skip_authorization
  end

  def set_params
    params.require(:tour_store_admin).permit(:email, :manager)
  end

end

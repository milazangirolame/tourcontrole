class BankingInformationsController < ApplicationController
  before_action :set_tour_store, only:[:new, :create, :edit, :update, :destroy, :show]
  before_action :set_banking_information, only: [:edit, :update, :destroy, :show]
  def new
    @banking_information = BankingInformation.new
    authorize @banking_information
  end

  def create
    @banking_information = BankingInformation.new(set_params)
    authorize @banking_information
    @banking_information.tour_store = @tour_store
    if @banking_information.save
      redirect_to tour_store_dashboard_path(@tour_store)
    else
      flash[:alert] = @banking_information.errors.first.second
      redirect_back fallback_location: tour_store_bank_path(@tour_store)
    end
  end

  def edit
  end

  def update
    @banking_information.update(set_params)
    if @banking_information.save
      redirect_to tour_store_bank_path(@tour_store)
    else
      flash[:alert] = @banking_information.errors.first.second
      redirect_back fallback_location: tour_store_bank_path(@tour_store)
    end
  end

  def show
  end

  def destroy
  end

  private

  def set_params
    params.require(:banking_information).permit(:account_type, :bank, :bank_ag, :bank_cc)
  end

  def set_tour_store
    @tour_store = TourStore.find_by_slug(params[:tour_store_slug])
  end

  def set_banking_information
    @banking_information = BankingInformation.find(params[:id])
    authorize @banking_information
  end
end

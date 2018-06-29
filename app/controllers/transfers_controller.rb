class TransfersController < ApplicationController
  before_action :set_tour_store, only: [:new, :create, :show, :index]
  before_action :set_transfer, only: [:show]

  def new
    @transfer = @tour_store.build_transfer
    authorize @transfer
  end

  def create
    @transfer = Transfer.new(set_params)
    @transfer.tour_store = @tour_store
    authorize @transfer
    if @transfer.save
      create_moip_transfer
      if @transfer.moip_id.present?
        redirect_to tour_store_transfer_path(@tour_store, @tranfer)
        flash[:notice] = 'Transferência criada com sucesso'
      else
        flash[:alert] = create_moip_transfer[:errors].first[:description]
        redirect_back fallback_location: tour_store_bank_path(@tour_store)
      end
    else
      render :new
    end
  end

  def show
  end

  def index
    @transfers = policy_scope(Transfer).where(tour_store: @tour_store)
  end

  def create_moip_transfer
    MoipApi.new(@tour_store).create_transfer(@transfer)
  end

  private

  def set_tour_store
    @tour_store = TourStore.find(params[:tour_store_slug])
  end

  def set_transfer
    @transfer = Transfer.find(params[:id])
    authorize @transfer
  end

  def set_params
    params.require(:transfer).permit(:tour_store, :moip_id, :amount)
  end
end

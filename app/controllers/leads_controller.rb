class LeadsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(set_params)
    skip_authorization
    if @lead.save
      flash[:notice] = 'Obrigado por se cadastrar a nossa mailing list'
      redirect_to landing_page_path
    else
      redirect_to landing_page_path
      flash[:alert] = @lead.errors
    end
  end

  private

  def set_params
    params.require(:lead).permit(:email)
  end

end

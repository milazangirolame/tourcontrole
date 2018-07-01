class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
  end

  def about
  end

  def terms
  end

  def cadastro
  end

  def landing_page
    @lead = Lead.new
  end

  def dummy_stores
    @stores = TourStore.where(dummy: true)
  end
end

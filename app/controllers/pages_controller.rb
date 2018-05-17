class PagesController < ApplicationController
  skip_before_action :authenticate_user!, except: [:new, :edit]

  def home
  end

  def about
  end
end

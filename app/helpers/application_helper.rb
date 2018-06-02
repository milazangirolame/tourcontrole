require_relative 'path_helper'
module ApplicationHelper

  def tourcontrole_page?
    !customer_page? && !pro_page?
  end

  def customer_page?
    page?('tour_stores#show, activities#show, booking_orders#new')
  end

  def is_admin?
    if @tour_store.present?
      @tour_store.users.include?(current_user)
      elsif @activity.present?
        @activity.tour_store.users.include?(current_user)
    else
      false
    end
  end

  def active(path)
    current_page?(path) ? 'active' : ''
  end

  def pro_page?
    page?('tour_stores#dashboard, tour_stores#edit ,tour_stores#users, tour_stores#tours,
      activities#new, activities#edit, activities#audit')
  end

  def show_navbar
    case
     when customer_page?
      'navbar_tour_store'
     when tourcontrole_page?
      'navbar_tourcontrole'
     when pro_page?
      'navbar_pro'
    end
  end

  def show_footer
    case
      when customer_page?
        'footer_tour_store'
      when tourcontrole_page?
        'footer_tourcontrole'
      when pro_page?
        'footer_pro'
    end
  end
end

require_relative 'path_helper'
module ApplicationHelper

  def tourcontrole_page?
    (@tour_store.nil? && @activity.nil?)  ||
    page?( 'tour_stores#dashboard, tour_stores#new, tour_stores#edit') ||
    page?('pages')
  end

  def customer_page?
    page?('tour_stores#show, activites#show')
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
    page?('tour_stores#dashboard, tour_stores#users, tour_stores#tours, activities#new, activities#edit')
  end

end

require_relative 'path_helper'
module ApplicationHelper

  def tourcontrole_page?
    (@tour_store.nil? && @activity.nil?)  ||
    page?( 'tour_stores#dashboard, tour_stores#new, tour_stores#edit') ||
    page?('pages')
  end

end

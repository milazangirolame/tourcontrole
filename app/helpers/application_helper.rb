require_relative 'path_helper'
module ApplicationHelper
  def tourcontrole_page?
    !customer_page? && !pro_page?
  end

  def customer_page?
    page?('tour_stores#show, activities#show, orders#new')
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

  def meta_title
    if customer_page?
      @tour_store.nil? ? "#{@activity.tour_store.name.capitalize}" : "#{@tour_store.name.capitalize}"
    else
      'Tourcontrole o motor de reservas online para prestadores de serviços turisticos'
    end
  end

  def meta_site_name
    if customer_page?
      @tour_store.nil? ? "#{@activity.tour_store.name.capitalize}" : "#{@tour_store.name.capitalize}"
    else
      'Tourcontrole'
    end
  end

  def meta_description
    if customer_page?
      @tour_store.nil? ? "#{@activity.tour_store.description}" : "#{@tour_store.description}"
    else
      'Com nossa plataforma  operadores turísticos conseguem oferecer  a seus clientes reservas online para seus passeios, eventos e excursões diretamente no seu próprio site. Gerencie suas vendas online e maneira rápida e simples, conquiste mais clientes já'
    end
  end

  def og_image
    unless customer_page?
      'https://docs.google.com/drawings/d/e/2PACX-1vQgKlAgL8qrjpyIXVE3EzpK0aWu1WGnP0bK28FwlkpiPUUgUAsjMGR2fdtMnpJMWbz6sk8xIIeTyrDm/pub?w=927&amp;h=579'
    end
  end
end

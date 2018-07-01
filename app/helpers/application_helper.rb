require_relative 'path_helper'
module ApplicationHelper
  def tourcontrole_page?
    !customer_page? && !pro_page?
  end

  def landing_page?
    page?('pages') ? (current_page?(landing_page_path) || current_page?(root_path)) : false
  end

  def padding_bottom
    'padding-bottom: 0px!important;' if landing_page?
  end

  def customer_page?
    page?('tour_stores#show, activities#show, orders#new')
  end

  def active(path)
    current_page?(path) ? 'active' : ''
  end

  def pro_page?
    page?('tour_stores#dashboard, tour_stores#events, tour_stores#edit,
      tour_stores#users, tour_stores#tours, tour_stores#company, tour_stores#bank,
      tour_stores#balance_details, tour_stores#transfer_index, banking_informations#new, banking_informations#edit, activities#new,
      activities#edit, activities#audit, orders#show, events#show, transfers,')
  end

  def show_navbar
    case
     when customer_page?
      'navbar_tour_store'
    when (tourcontrole_page? && !landing_page?)
      'navbar_tourcontrole'
     when pro_page?
      'navbar_pro'
    when landing_page?
      'navbar_landing_page'
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
      @activity.nil? ? "#{@tour_store.name.capitalize}" : "#{@activity.name.capitalize}"
    else
      'Tourcontrole o motor de reservas online para prestadores de serviços turísticos'
    end
  end

  def meta_site_name
    if customer_page?
      @activity.nil? ? "#{@tour_store.name.capitalize}" : "#{@activity.name.capitalize}"
    else
      'Tourcontrole'
    end
  end

  def meta_description
    if customer_page?
      @activity.nil? ? "#{@tour_store.description}" : "#{@activity.description}"
    else
      'Com nossa plataforma  operadores turísticos conseguem oferecer  a seus clientes reservas online para seus passeios, eventos e excursões diretamente no seu próprio site. Gerencie suas vendas online e maneira rápida e simples, conquiste mais clientes já'
    end
  end

  def meta_image
    if customer_page?
      @activity.nil? ? tour_store_banner_image : activity_first_image(@activity)
    else
      'https://docs.google.com/drawings/d/e/2PACX-1vQgKlAgL8qrjpyIXVE3EzpK0aWu1WGnP0bK28FwlkpiPUUgUAsjMGR2fdtMnpJMWbz6sk8xIIeTyrDm/pub?w=927&amp;h=579'
    end
  end

  def get_tour_store
    @tour_store.nil? ? @activity.tour_store : @tour_store
  end

  def logo_link
    tour_store_path(get_tour_store)
  end

  def logo_image
    get_tour_store.logo.present? ? get_tour_store.logo : "customer_logo_placeholder.png"
  end

  def tour_store_card_image(tour_store)
    tour_store.image_banner.present? ? (cl_image_path tour_store.image_banner) : 'https://kitt.lewagon.com/placeholder/cities/tokyo'
  end

  def tour_store_banner_image
    @tour_store.image_banner.present? ? (cl_image_path @tour_store.image_banner) : 'https://kitt.lewagon.com/placeholder/cities/berlin'
  end

  def activity_first_image(activity)
    activity.photos.any? ? (cl_image_path activity.photos.order(created_at: :desc).first.image ) : 'https://kitt.lewagon.com/placeholder/cities/sao-paulo'
  end

  def activity_last_image(activity)
    activity.photos.any? ? (cl_image_path activity.photos.order(created_at: :desc).last.image ) : 'https://kitt.lewagon.com/placeholder/cities/random'
  end

  def buyer_icon(guest)
    guest.buyer ? '<i class="fas fa-money-bill-alt"></i>'.html_safe : ''
  end

  def date(string)
    string.to_date.to_formatted_s(:rfc822)
  end

  def is_manager?
    user_signed_in? ? get_tour_store.tour_store_admins.find_by(user: current_user).manager : false
  end

  def is_admin?
    user_signed_in? ? get_tour_store.tour_store_admins.include?(current_user) : false
  end

end

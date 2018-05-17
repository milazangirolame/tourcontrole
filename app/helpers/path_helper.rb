module PathHelper

  ##
  # Checks whether you are on the specified page
  #
  # @param matchers A comma separated list of matchers.
  # @param returnval Return value if the page matches or nil. Defaults to true.
  # @return [mixed] returnval (usually truthy) on success or nil on failure.
  #
  # @example Check if you are on Article#show
  #   page?( 'article#show' )
  # @example Check if on Article#show or News#index
  #   page?( 'article#show, news#index' )
  # @example Check if you are in the article controller under the admin scope
  #   page?( 'admin/articles#index' )
  # @example Check if you are in the article controller and return `'active'`
  #   page?( 'article', 'active' )
  # @example Check aditional parameters and return `'active'` (for use as class)
  #   page?( "article#show?slug=#{@article.slug}", 'active' )
  #
  # ==== Matchers
  # Matchers are a comma separated list of rules specified with the following
  # format. Whitespace between matchers is allowed.
  #    controller#action?param1=value&param2=value
  # Values should be URL encoded if they contain special characters.
  #
  #
  # ==== LICENSE
  # Copyright (c) 2015-2017 Itay Grudev <itay[]grudev.com>
  # Published under the terms of The MIT License (MIT)
  #
  def page?( matchers, returnval = true )
    matchers.split( ',' ).each do |matcher|
      # Split the routing part and the parameters part
      routing, params = matcher.strip.split( '?' )
      # Split the controller from the action
      controller, action = routing.strip.split( '#' ) unless routing.blank?
      # Split multiple parameters
      params = params.strip.split( '&' ) unless params.blank?

      next if ! controller.blank? and request.params[:controller] != controller
      next if ! action.blank? and request.params[:action] != action

      # Verify parameters
      matches = true
      params.try( :each ) do |param|
        # Split parameter key from value
        key, value = param.strip.split( '=' )
        if request.params[key] != URI.unescape( value )
          matches = false and break
        end
      end
      next unless matches

      return returnval
    end

    nil
  end

end

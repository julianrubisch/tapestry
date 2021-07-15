class ApplicationController < ActionController::Base
  helper_method :base_url

  def base_url
    request.base_url
  end
end

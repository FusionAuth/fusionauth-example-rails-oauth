class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?

  def current_user
    if session[:user_jwt]
      token = session[:user_jwt]
      decoded = TokenService.decode(token["value"])
      decoded.first["email"]
    end

  end

  def logged_in?
    current_user.present?
  end

  protected

  def idp_url
    Rails.configuration.x.oauth.idp_url
  end

  def client_id
    Rails.configuration.x.oauth.client_id
  end

  def client_secret
    Rails.configuration.x.oauth.client_secret
  end

  def redirect_uri
    Rails.config.x.oauth.redirect_uri
  end

end

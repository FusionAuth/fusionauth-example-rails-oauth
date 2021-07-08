class OAuthController < ApplicationController
  def initialize
    @oauth_client = OAuth2::Client.new(Rails.configuration.x.oauth.client_id,
                                       Rails.configuration.x.oauth.client_secret,
                                       authorize_url: '/oauth2/authorize',
                                       site: Rails.configuration.x.oauth.idp_url,
                                       token_url: '/oauth2/token',
                                       redirect_uri: Rails.configuration.x.oauth.redirect_uri)
  end

  # The OAuth callback
  def oauth_callback
    # Make a call to exchange the authorization_code for an access_token
    response = @oauth_client.auth_code.get_token(params[:code])

    # Extract the access token from the response
    token = response.to_hash[:access_token]

    # Decode the token
    begin
      decoded = TokenDecoder.new(token, @oauth_client.id).decode
    rescue Exception => error
      "An unexpected exception occurred: #{error.inspect}"
      Rails.logger.warn("An unexpected exception occurred: #{error.inspect}")
      session[:user_jwt] = nil

      redirect_to root_path
      return
    end

    # Set the token on the user session
    session[:user_jwt] = {value: decoded, httponly: true}

    redirect_to root_path
  end

  def endsession
    # Reset Rails session
    reset_session
    redirect_to root_path
  end

  def logout
    redirect_to Rails.configuration.x.oauth.idp_url+"oauth2/logout?client_id="+Rails.configuration.x.oauth.client_id
  end

  def login
    redirect_to @oauth_client.auth_code.authorize_url
  end
end

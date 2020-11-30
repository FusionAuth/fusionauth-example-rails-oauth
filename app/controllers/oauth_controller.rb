class OauthController < ApplicationController
  def initialize
    @redirect_uri = "http://localhost:3000/oauth2-callback"
  end

  # The OAuth callback
  def oauth_callback
    code = params[:code]

    # Create an OAuth2 client to communicate with the auth server
    client = OAuth2::Client.new(client_id,
                                client_secret,
                                site: idp_url,
                                token_url: '/oauth2/token')

    # Make a call to exchange the authorization_code for an access_token
    token = client.auth_code.get_token(params[:code],
                                       'redirect_uri': @redirect_uri)

    # Set the token on the user session
    session[:user_jwt] = { value: token.to_hash[:access_token], httponly: true }

    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
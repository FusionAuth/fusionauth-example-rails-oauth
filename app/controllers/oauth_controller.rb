class OauthController < ApplicationController
  # The OAuth callback
  def oauth_callback
    # Create an OAuth2 client to communicate with the auth server
    client = OAuth2::Client.new(client_id,
                                client_secret,
                                site: idp_url,
                                token_url: '/oauth2/token')

    # Make a call to exchange the authorization_code for an access_token
    response = client.auth_code.get_token(params[:code],
                                          'redirect_uri': redirect_uri)

    # Extract the access token from the response
    token = response.to_hash[:access_token]

    # Decode the token
    begin
      decoded = TokenDecoder.new(token, client_id).decode
    rescue
      head :forbidden
      return
    end

    # Set the token on the user session
    session[:user_jwt] = {value: decoded, httponly: true}

    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
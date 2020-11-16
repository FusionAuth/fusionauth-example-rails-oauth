class OauthController < ApplicationController
  def initialize
    @redirect_uri = "http://localhost:3000/oauth2-callback"
  end

  def oauth_callback
    code = params[:code]
    query = { code: code,
              grant_type: "authorization_code",
              client_id: client_id,
              client_secret: client_secret,
              redirect_uri: @redirect_uri }.to_query

    response = RestClient.post("#{idp_url}oauth2/token?" << query, {})
    token = JSON.parse(response.body)["access_token"]
    session[:user_jwt] = {value: token, httponly: true}
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
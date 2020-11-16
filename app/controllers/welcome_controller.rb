class WelcomeController < ApplicationController

  def index
    build_login_url
    build_logout_url
  end

  private

  def build_login_url
    query = {
        client_id: client_id,
        client_secret: client_secret,
        response_type: "code",
        redirect_uri: "http://localhost:3000/oauth2-callback"
    }.to_query

    @login_url = "#{idp_url}oauth2/authorize?#{query}"
  end

  def build_logout_url
    query = { client_id: client_id }.to_query
    @logout_url= "#{idp_url}oauth2/logout?#{query}"
  end

end

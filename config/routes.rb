Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/oauth2-callback', to: 'o_auth#oauth_callback'
  get '/logout', to: 'o_auth#logout'
  get '/endsession', to: 'o_auth#endsession'
  get '/login', to: 'o_auth#login'
end

**This repo is out of date and is archived. Check out [an updated tutorial on using FusionAuth with Ruby on Rails](https://fusionauth.io/docs/quickstarts/quickstart-ruby-rails-web) or [the updated GitHub repository](https://github.com/FusionAuth/fusionauth-quickstart-ruby-on-rails-web).**


# FusionAuth Ruby on Rails example

This project contains the companion code for [How to securely implement OAuth in Ruby on Rails](https://fusionauth.io/blog/2020/12/14/how-to-securely-implement-oauth-rails/). It demonstrates how to integrate with FusionAuth's OAuth system using the Authorization Code grant.

## Requirements

* Ruby version
2.7

* Rails version
6

## To run

This assumes you already have a running FusionAuth instance, user and application running locally. If you don't, please see the [5-Minute Setup Guide](https://fusionauth.io/docs/v1/tech/5-minute-setup-guide) to do so.

* For further specific configuration details, see [How to securely implement OAuth in Ruby on Rails](https://fusionauth.io/blog/2020/12/14/how-to-securely-implement-oauth-rails/).

* Create a new FusionAuth application
* Add a redirect url of http://localhost:3000/oauth2-callback
* Make sure you add http://localhost:3000/endsession as the logout URL
* Save the application
* Get the client id and client secret and update config/environments/development.rb 
* Update the tenant's issuer by going to "Tenants" and editing your tenant. Go to the "General" tab and change the "Issuer" to be `fusionauth.io`. Save the tenant.
* Register the user for the application
* Install dependencies
```
bundle install
```
* Get the HMAC secret used to sign the JWTs by going to Key Master in FusionAuth. Set the HMAC_SECRET environment variable to this value.
* Start the server: `HMAC_SECRET='2l...' rails s`
* Visit localhost:3000 and log in.

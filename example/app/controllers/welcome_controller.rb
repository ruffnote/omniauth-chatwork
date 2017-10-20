class WelcomeController < ApplicationController
  def index
  end

  def callback
    token = auth.credentials.token
    @token = token

    client = OAuth2::Client.new(ENV['CHATWORK_CLIENT_ID'], ENV['CHATWORK_CLIENT_SECRET'], site: 'https://api.chatwork.com')
    access_token = OAuth2::AccessToken.new(client, token)
    # access_token.refresh! if access_token.expired?

    @teams = access_token.get('/v2/me').parsed
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end

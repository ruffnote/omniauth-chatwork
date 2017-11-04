class WelcomeController < ApplicationController
  def index
  end

  def callback
    @auth = auth
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end

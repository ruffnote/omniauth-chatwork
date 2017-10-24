# Omniauth::Chatwork

- API Doc

http://developer.chatwork.com/ja/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-chatwork'
```

## Usage

example/README.mdに記載

- RubyOnRailsでの設定方法について

```
# config/initializers/omniauth.rb

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :chatwork, ENV['CHATWORK_CLIENT_ID'], ENV['CHATWORK_CLIENT_SECRET'], scope: 'xxx' # xxx maybe users.all:read
end
OmniAuth.config.logger = Rails.logger
```

```
# cofig/routes

Rails.application.routes.draw do
  get '/auth/chatwork/callback', to: 'welcome#callback'
end
```


```
# call chatwork api

<%= link_to 'CHATWORK OAUTH', '/auth/chatwork' %>
```

```
# welcome#callback

def callback
  @auth = auth
  otken = auth.credentials.token

  client = OAuth2::Client.new(ENV['CHATWORK_CLIENT_ID'], ENV['CHATWORK_CLIENT_SECRET'], site: 'https://api.chatwork.com')
  access_token = OAuth2::AccessToken.new(client, token)
  # access_token.refresh! if access_token.expired?
end

private
def auth
  request.env['omniauth.auth']
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/omniauth-chatwork. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

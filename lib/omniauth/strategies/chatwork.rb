require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class ChatWork < OmniAuth::Strategies::OAuth2
      option :client_options, {
        site: 'https://api.chatwork.com',
        authorize_url: 'https://www.chatwork.com/packages/oauth2/login.php',
        token_url: 'https://oauth.chatwork.com/token',
        auth_scheme: :basic_auth
      }

      uid do
        raw_info['account_id'].to_s
      end

      info do
        {
          'name': raw_info['name'],
          'image': raw_info['avatar_image_url'],
          'email': raw_info['login_mail'],
          'chatwork_id': raw_info['chatwork_id'],
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        @raw_info ||= access_token.get('/v2/me').parsed
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end

OmniAuth.config.add_camelization 'chatwork', 'ChatWork'

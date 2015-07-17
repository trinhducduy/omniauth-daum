require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Daum < OmniAuth::Strategies::OAuth2
      option :name, "daum"

      option :client_options, {
        :site => "https://apis.daum.net",
        :authorize_url => "https://apis.daum.net/oauth2/authorize",
        :token_url => "https://apis.daum.net/oauth2/token"
      }

      uid{ raw_info['id'] }

      info do
        {
          :name => raw_info['nickname'],
          :email => raw_info['email'],
          :image => raw_info['profile_big_image_url']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('https://apis.daum.net/user/v1/show').parsed
      end
    end
  end
end

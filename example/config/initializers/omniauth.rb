Rails.application.config.middleware.use OmniAuth::Builder do
  provider :chatwork, ENV['CHATWORK_CLIENT_ID'], ENV['CHATWORK_CLIENT_SECRET'], scope: "users.all:read"
end
OmniAuth.config.logger = Rails.logger

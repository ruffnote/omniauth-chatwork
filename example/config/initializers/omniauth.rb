Rails.application.config.middleware.use OmniAuth::Builder do
  provider :chatwork, ENV['CHATWORK_CLIENT_ID'], ENV['CHATWORK_CLIENT_SECRET'], scope: "all"
end
OmniAuth.config.logger = Rails.logger

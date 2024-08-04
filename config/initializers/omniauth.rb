Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           ENV.fetch('GOOGLE_CLIENT_ID'),
           ENV.fetch('GOOGLE_CLIENT_SECRET')
end

OmniAuth.configure do |config|
  next if Rails.env.production?

  config.test_mode = true
  config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
    uid: 'dummy',
    info: { email: 'dev@ga-tech.co.jp', name: '開発者ユーザー' },
    credentials: { token: 'dummy' },
  )
end

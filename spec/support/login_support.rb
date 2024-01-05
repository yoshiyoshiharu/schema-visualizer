# frozen_string_literal: true

module LoginSupport
  def login_as(user)
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      info: {
        name: user.name,
        email: user.email
      }
    )

    get '/auth/google_oauth2/callback'
  end
end

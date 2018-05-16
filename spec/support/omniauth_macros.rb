module OmniauthMacros
  def github_auth_hash
    OmniAuth.config.mock_auth[:github] = {
      provider: 'github',
      uid: '123545',
      info: {
        email: 'mockemail@gmail.com',
        name: 'user'
      },
      credentials: {
        token: 'mock_token',
        secret: 'mock_secret'
      }
    }
  end
end
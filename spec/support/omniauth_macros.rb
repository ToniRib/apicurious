module OmniauthMacros
  def mock_auth_hash
    OmniAuth.config.mock_auth[:fitbit] = OmniAuth::AuthHash.new({
      provider: "fitbit",
      uid: ENV["mock_user_uid"],
      credentials: { token: ENV["mock_auth_token"] },
      extra: {
        raw_info: {
          user: {
            fullName: "Toni Rib",
            avatar: "https://d6y8zfzc2qfsl.cloudfront.net/38056F54-AF8E-F890-D53A-C7EAC631101A_profile_100_square.jpg",
            displayName: "Toni"
          }
        }
      }
    })
  end
end

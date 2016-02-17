Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fitbit, ENV["consumer_key"],
                    ENV["consumer_secret"],
                    { :scope => "profile activity heartrate sleep social weight",
                      :redirect_uri => "http://localhost:3000/auth/fitbit/callback" }
end

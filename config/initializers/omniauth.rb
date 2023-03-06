Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,
          ENV['GITHUB_CLIENT_ID'],
          ENV['GITHUB_SECRETS'],
          callback_path: "/auth/github/callback",
          scope: "user"
  
  OmniAuth.config.on_failure = 
    Proc.new { |env| OmniAuth::FailureEndpoint.new(env).redirect_to_failure }
end
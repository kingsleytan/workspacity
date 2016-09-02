OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["FB_ID"], ENV["FB_SECRET"]
            # :scope => 'public_profile, email',
            # :info_fields => 'email'

end

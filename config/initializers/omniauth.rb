OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["505503122976262"], ENV["3e387bd9eb1cee72fb794cf0ba3d1892"]
            # :scope => 'public_profile, email',
            # :info_fields => 'email'

end

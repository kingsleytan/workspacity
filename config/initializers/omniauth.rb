OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "170933120009757", "c44b2316e3d7595190cf30a74694ea80",
  client_options: {
    site: 'https://graph.facebook.com/v2.7',
    authorize_url: "https://www.facebook.com/v2.7/dialog/oauth"
  }
end

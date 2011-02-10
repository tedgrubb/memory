Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, '0f8813f4a483be7538c9c8ab4ed9d8dc', '0e6ffca9bf393917678b5e9d9d5630e3'
end
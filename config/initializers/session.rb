PalavaHq::Application.config.secret_token  = '9c37d938-a0fe-422b-8d1a-8291e8a288bc'
PalavaHq::Application.config.cookie_secret = '6f3ae71b-f0e2-4c16-ab72-043029a200f7'
PalavaHq::Application.config.session_store(
  :cookie_store,
  key: '_palava_hq',
  expire_after: 96.hours,
  httponly: true,
  secure: Rails.env.production?,
)
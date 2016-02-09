Devise.secret_key = "0ebc6bf953231426abeaf57c20d5e808225cd55341fb9edfd4fe9fa732769e7af8ab6b389bffa3e56c762278825a5db8f3de"

Devise.setup do |config|
  # Required so users don't lose their carts when they need to confirm.
  config.allow_unconfirmed_access_for = 1.days

  # Fixes the bug where Confirmation errors result in a broken page.
  config.router_name = :spree

  # Add any other devise configurations here, as they will override the defaults provided by solidus_auth_devise.
  config.omniauth :facebook, ENV['NATTY_FB_APP_ID'], ENV['NATTY_FB_APP_SECRET'],
    scope: 'public_profile,email',
    info_fields: 'first_name,last_name,email,picture'
end

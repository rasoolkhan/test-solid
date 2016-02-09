# This migration comes from spree (originally 20140309033438)
class CreateStoreFromPreferences < ActiveRecord::Migration
  def change
    preference_store = Spree::Preferences::Store.instance
    if store = Spree::Store.where(default: true).first
      store.meta_description = preference_store.get('spree/app_configuration/default_meta_description') {}
      store.meta_keywords    = preference_store.get('spree/app_configuration/default_meta_keywords') {}
      store.seo_title        = preference_store.get('spree/app_configuration/default_seo_title') {}
      store.description      = "dummy"
      store.logo             = Spree::ImageLogo.new(attachment: File.new('app/assets/images/logo/natty.png'))
      store.image            = Spree::ImageBanner.new(attachment: File.new('app/assets/images/logo/natty.png'))
      store.save!
    else
      # we set defaults for the things we now require
      Spree::Store.new do |s|
        s.name              = preference_store.get 'spree/app_configuration/site_name' do
          'Sample Store'
        end
        s.url               = preference_store.get 'spree/app_configuration/site_url' do
          'example.com'
        end
        s.mail_from_address = preference_store.get 'spree/app_configuration/mails_from' do
          'store@example.com'
        end

        s.meta_description = preference_store.get('spree/app_configuration/default_meta_description') {}
        s.meta_keywords    = preference_store.get('spree/app_configuration/default_meta_keywords') {}
        s.seo_title        = preference_store.get('spree/app_configuration/default_seo_title') {}
        s.default_currency = preference_store.get('spree/app_configuration/currency') {}
        s.code             = 'spree'
        s.description      = "dummy"
        s.logo             = Spree::ImageLogo.new(attachment: File.new('app/assets/images/logo/natty.png'))
        s.image            = Spree::ImageBanner.new(attachment: File.new('app/assets/images/logo/natty.png'))
      end.save!
    end
  end
end

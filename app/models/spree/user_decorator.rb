module Spree
	User.class_eval do
		devise :omniauthable, omniauth_providers: [:facebook]

		has_one :seller

		validates :first_name, presence: true
		validates :last_name, presence: true

		def is_seller?
			has_spree_role?('store_admin')
    end

		def is_buyer_only?
			has_spree_role?('user') && !is_seller?
    end

		def self.from_omniauth(auth)
			user = where(email: auth.info.email).first
			if user.blank?
				password = Devise.friendly_token[0,20]
				user = Spree::User.new(
					provider: auth.provider,
					uid: auth.uid,
	        first_name: auth.info.first_name,
	        last_name: auth.info.last_name,
	        email: auth.info.email,
	        password: password,
	        password_confirmation: password,
	        confirmation_sent_at: Time.zone.now,
	        confirmed_at: Time.zone.now,
	      )
				user.spree_roles << Spree::Role.find_by_name("user")
	      user.save!
			elsif user.provider.blank?
				user.update(
					provider: auth.provider,
					uid: auth.uid,
					first_name: auth.info.first_name,
	        last_name: auth.info.last_name,
					confirmation_sent_at: Time.zone.now,
	        confirmed_at: Time.zone.now
				)
			end
			return user
		end

		def self.new_with_session(params, session)
	    super.tap do |user|
	      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
	        user.email = data["email"] if user.email.blank?
	      end
	    end
	  end

		def self.to_csv
			::CSV.generate do |csv|
				csv << [
					'Name',
					'Email',
					'Provider',
					'Roles'
				]
				all.each do |user|
					csv << [
						"#{user.first_name} #{user.last_name}",
						user.email,
						user.provider.present? ? user.provider : 'email',
						user.spree_roles.pluck(:name).join(", ")
					]
				end
			end
		end
	end
end

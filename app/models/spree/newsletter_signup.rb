module Spree
	class NewsletterSignup < ActiveRecord::Base
		validates :email, presence: true, uniqueness: true

		def self.to_csv
			::CSV.generate do |csv|
				csv << [
					'Email'
				]
				all.each do |user|
					csv << [
						user.email
					]
				end
			end
		end
	end
end

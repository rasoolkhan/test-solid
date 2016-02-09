module Spree
	module Admin
		class NewsletterSignupController < Spree::BaseController
			before_action :auth_admin

	    def index
				respond_to do |format|
					format.csv { send_data Spree::NewsletterSignup.all.to_csv }
          format.xls
				end
	    end
		end
  end
end

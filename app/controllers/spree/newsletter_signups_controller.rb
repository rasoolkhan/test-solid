module Spree
	class NewsletterSignupsController < Spree::BaseController
		before_action :auth_not_admin

    def create
			newsletter_signup = Spree::NewsletterSignup.create(spree_newsletter_signup_params)
			if newsletter_signup.save
				flash[:notice] = "Thank you for signing up"
			else
				flash[:error] = newsletter_signup.errors.full_messages
			end
			redirect_to(:back)
    end

    private

      def spree_newsletter_signup_params
        params.require(:newsletter_signup).permit(Spree::PermittedAttributes.newsletter_signup_attributes)
      end

  end
end

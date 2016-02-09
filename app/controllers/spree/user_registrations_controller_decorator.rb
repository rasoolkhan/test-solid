module Spree
	UserRegistrationsController.class_eval do
		before_action :auth_not_admin, only: [:new, :create]
		before_action :auth_not_seller, only: [:new, :create]

		def new
			if request.path.include?('seller')
				build_resource({})
				render 'new_seller'
			elsif request.path.include?('learn')
				build_resource({})
				render 'learn_more'
			elsif request.path.include?('toolkit')
				build_resource({})
				render 'about_toolkit'
			else
				super
			end
	  end

		def create
	    build_resource(spree_user_params)
	    if resource.save
	      set_flash_message(:natty, :signed_up_but_unconfirmed)
	      sign_in(:spree_user, resource)
	      session[:spree_user_signup] = true
	      associate_user
        resource.spree_roles << Spree::Role.find_by_name("user")
        if params[:user_type].present? && params[:user_type] == "seller"
          respond_with resource, location: new_supplier_store_path
        else
          respond_with resource, location: after_sign_up_path_for(resource)
        end
	    else
	      clean_up_passwords(resource)

				if Spree::User.where(provider: 'facebook', email: resource.email).count > 0
					resource.errors.clear
					resource.errors.add(:base, 'You have already registered via Facebook. Please login using Facebook.')
				end

	      respond_with(resource) do |format|
	        format.html { render :new }
	      end
			end
	  end

    private

    def spree_user_params
      params.require(:spree_user).permit(Spree::PermittedAttributes.user_attributes)
    end
	end
end

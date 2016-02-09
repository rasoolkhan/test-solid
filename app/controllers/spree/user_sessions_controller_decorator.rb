module Spree
		UserSessionsController.class_eval do

			def create
		    authenticate_spree_user!

		    if spree_user_signed_in?
		      respond_to do |format|
		        format.html do
		          flash[:success] = Spree.t(:logged_in_succesfully)
							if spree_current_user.is_seller?
								redirect_to supplier_store_path(spree_current_user.seller.store)
							else
								redirect_back_or_default(after_sign_in_path_for(spree_current_user))
							end
		        end
		        format.js { render success_json }
		      end
		    else
		      respond_to do |format|
		        format.html do
		          flash.now[:error] = t('devise.failure.invalid')
		          render :new
		        end
		        format.js do
		          render json: { error: t('devise.failure.invalid') },
		            status: :unprocessable_entity
		        end
		      end
		    end
		  end

	end
end

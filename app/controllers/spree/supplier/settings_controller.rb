module Spree
	module Supplier
    class SettingsController < Spree::StoreController
      before_action :this_seller
			before_action :store_approved, only: [:store_edit, :store_update]

      def store_edit
      end

      def store_update
				logo = spree_store_params[:logo_attributes]
				image = spree_store_params[:image_attributes]
				params[:store].delete(:logo_attributes)
				params[:store].delete(:image_attributes)
        params[:store].delete(:logo_attributes)
				if @store.update(spree_store_params)
          @store.seller.update(alternate_name: params[:alternate_name], alternate_email: params[:alternate_email], alternate_phone: params[:alternate_phone])
					@store.logo = Spree::ImageLogo.new(logo) if logo.present?
					@store.image = Spree::ImageBanner.new(image) if image.present?
					redirect_to supplier_store_path(@store)
				else
					render 'store_edit'
				end
			end

			def banking_edit
      end

			def banking_update
				if @store.seller.update(spree_seller_params)
					redirect_to supplier_store_path(@store)
				else
					render 'banking_edit'
				end
      end

			def policies_edit
				@policies = @store.policies
				@policy = Spree::StorePolicy.new(store: @store)
      end

			def policies_update
				policies = []
				spree_policy_params.each do |k, v|
					puts "Saving #{v[:heading]}, #{v[:description]}"
					policies << Spree::StorePolicy.create(store: @store, heading: v[:heading], description: v[:description])
				end
				@store.policies = policies
				redirect_to supplier_store_path(@store)
			end

      private

			def this_seller
				@store = Spree::Store.friendly.find(params[:store_id])
				correct_seller @store.seller.user
			end

      def spree_store_params
        local_params = params.require(:store).permit(Spree::PermittedAttributes.store_attributes)
				local_params[:office_address_attributes][:user_id] = spree_current_user.id
				local_params[:office_address_attributes][:default] = true
				local_params[:office_address_attributes][:archived] = false
        local_params[:office_address_attributes][:address_attributes][:firstname] = "nil"
				local_params[:office_address_attributes][:address_attributes][:lastname] = "nil"
				local_params[:office_address_attributes][:address_attributes][:country_id] = "1"
        local_params
      end

			def spree_seller_params
				params.require(:seller).permit(:bank_name, :bank_branch, :bank_address, :bank_account_name, :bank_account_number, :bank_ifsc, :bank_micr, :bank_pan, :bank_tin, :bank_vat)
			end

			def spree_policy_params
				local_params = params[:store]
				local_params[:policies_attributes].present? ? local_params[:policies_attributes].select { |k, v| (k != "") && (v[:heading] != "") && (v[:description] != "") } : []
			end
    end
  end
end

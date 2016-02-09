module Spree
	module Supplier
    class StoresController < Spree::StoreController
			before_action :auth_buyer, only: [:new, :create]
			before_action :this_seller, only: [:show, :edit, :update]
			before_action :store_not_approved, only: [:edit, :update]

      def new
				@store = Spree::Store.new
				@store.build_office_address.build_address(country: Spree::Country.first)
				@store.build_seller
				@store.build_logo
				@store.build_image
				@product_samples = []
				3.times do |index|
				  @product_samples << Spree::ProductSample.new
					@product_samples[index].build_image
				end
      end

      def create
				begin
					Spree::Store.friendly.find(params[:slug])
					params[:store].delete(:slug)
				rescue ActiveRecord::RecordNotFound
				end
        @store = Spree::Store.new(spree_store_params)
				@categories = params[:store_cat]
				social_urls = []
				params[:social_url].each do |k, v|
					social_urls << v
				end
				@store.social_urls = social_urls.join(",")
				@store.code = (Spree::Store.last.id + 1).to_s

        if @store.save
					@store.sample_taxons = Spree::Taxon.find(@categories) if @categories.present?
					spree_current_user.spree_roles << Spree::Role.find_by_name("store_admin")
          @store.pending!
					flash[:notice] = "Thank you for signing up. We will enable your store after verifying your submission."
          redirect_to supplier_store_path(@store)
        else
					@store.office_address.address.country = Spree::Country.first
					@product_samples = []
					spree_store_params[:product_samples_attributes].each do |k, v|
						@product_samples << Spree::ProductSample.new(v)
						@product_samples[k.to_i].build_image
					end
          render 'new'
        end
      end

      def show
				render 'home'
      end

			def edit
				@categories = @store.sample_taxons.present? ? @store.sample_taxons.pluck(:id) : []
				@product_sample = Spree::ProductSample.new
				@product_sample.build_image
				@product_samples = @store.product_samples.select { |sample| sample.image.present? || (sample.name != "") || (sample.description != "") }
				@social_urls = @store.social_urls.split(",")
			end

			def update
				@categories = params[:store_cat]
				product_samples = @store.product_samples
				new_product_samples = spree_store_params[:product_samples_attributes]
				logo = spree_store_params[:logo_attributes]
				image = spree_store_params[:image_attributes]
				params[:store].delete(:product_samples_attributes)
				params[:store].delete(:logo_attributes)
				params[:store].delete(:image_attributes)
				if @store.update(spree_store_params)
					@store.sample_taxons = Spree::Taxon.find(@categories) if @categories.present?
					@store.logo = Spree::ImageLogo.new(logo) if logo.present?
					@store.image = Spree::ImageBanner.new(image) if image.present?
					@store.product_samples = product_samples
					new_product_samples.each do |k, v|
						@store.product_samples << Spree::ProductSample.new(v)
					end
					social_urls = []
					params[:social_url].each do |k, v|
						social_urls << v
					end
					@store.update(social_urls: social_urls.join(","))
					redirect_to supplier_store_path(@store)
				else
					@product_sample = Spree::ProductSample.new
					@product_sample.build_image
					render 'edit'
				end
			end

			def slug
				store = nil
				begin
					store = Spree::Store.friendly.find(params[:slug])
				rescue ActiveRecord::RecordNotFound
				end
				render json: {available: !store.present?}.to_json
			end

			# Commented by Neil: Supreets code
      # def update
      #   @store = Spree::Store.friendly.find(params[:id])
      #   if params[:bankinfo].present?
      #     @bank_detail = @store.seller.build_bank_detail(spree_bankinfo_params)
      #     @bank_detail.save!
      #   end
      #   @store.update_attributes(spree_store_params)
      #   if @store.save!
      #     redirect_to supplier_store_path(@store.id)
      #   end
      # end

      def settings
        @store = Spree::Store.friendly.find(params[:id])
        @seller = @store.seller
        @categories = Spree::Taxonomy.find_by_name('categories').taxons
      end

      def orders
        @store = Spree::Store.friendly.find(params[:id])
        @store_orders = @store.store_orders
      end

      private

			def this_seller
				@store = Spree::Store.friendly.find(params[:id])
				correct_seller @store.seller.user
			end

			def store_not_approved
				if @store.approved?
					redirect_to supplier_store_path(@store)
				end
			end

			def spree_store_params
        local_params = params.require(:store).permit(Spree::PermittedAttributes.store_attributes)
				local_params[:url] = "default"
				local_params[:mail_from_address] = Spree::Config[:mails_from]
				local_params[:seller_attributes][:user_id] = spree_current_user.id if local_params[:seller_attributes].present?
				local_params[:office_address_attributes][:user_id] = spree_current_user.id
				local_params[:office_address_attributes][:default] = true
				local_params[:office_address_attributes][:archived] = false
				local_params[:office_address_attributes][:address_attributes][:firstname] = "nil"
				local_params[:office_address_attributes][:address_attributes][:lastname] = "nil"
				local_params[:office_address_attributes][:address_attributes][:country_id] = "1"
				local_params
      end
    end
	end
end

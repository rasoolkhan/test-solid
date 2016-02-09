module Spree
	module Supplier
    class ProductsController < Spree::StoreController
			before_action :this_seller
			before_action :store_approved

      def index
				@products = @store.products
      end

			def new
        @product = Spree::Product.new
      end

      def create
				option_type_new = []
				option_new_names = params[:product][:option_new_name]
				option_new_names.each do |k, v|
					option_type = Spree::OptionType.new(name: v, presentation: v, store: @store)
					if option_type.save
						option_type_new << option_type
						option_values = params[:product][:option_new_values][k.to_s].split(',')
						option_values.each do |option_value|
							Spree::OptionValue.create(option_type: option_type, name: option_value.strip, presentation: option_value.strip) unless option_value.strip == ""
						end
					end
				end
				@product = Spree::Product.new(store_product_params)
				@product.store = @store
				@product.meta_description = @product.description
				@product.available_on = Date.yesterday
				@product.guide_label = 'Size Guide'
				@product.shipping_category_id = 1
				slug_id = Spree::Product.count == 0 ? 1 : Spree::Product.reorder(id: :desc).first.id + 1
				@product.sku = "#{@store.slug}-#{slug_id}-master"
				@product.price = 0.00
				if @product.save
					@product.pending!
					stock_item = @product.master.stock_items.first
					store_stock_location = Spree::StockLocation.where(store: @store).first
	        if store_stock_location.present?
	          stock_item.stock_location = store_stock_location
	        else
	          stock_item.stock_location = Spree::StockLocation.new(store: @store, name: @store.name, propagate_all_variants: false)
	        end
	        stock_item.save!
					params[:product][:taxon_ids_3].each do |k, taxon_id_3|
						taxon = nil
						if taxon_id_3.present?
							taxon = Spree::Taxon.find(taxon_id_3)
						elsif params[:product][:taxon_ids_2][k.to_s].present?
							taxon = Spree::Taxon.find(params[:product][:taxon_ids_2][k.to_s])
						elsif params[:product][:taxon_ids_1][k.to_s].present?
							taxon = Spree::Taxon.find(params[:product][:taxon_ids_1][k.to_s])
						end
						@product.taxons << taxon unless taxon.nil? || @product.taxons.exists?(taxon)
					end
					@product.option_types = Spree::OptionType.find(params[:product][:option_type_ids].select { |id| id != "" })
					option_type_new.each do |option_type|
						@product.option_types << option_type
					end
					property_names = []
					params[:product][:property_names].each do |k, v|
						property_names << v unless v == ""
					end
					property_values = []
					params[:product][:property_values].each do |k, v|
						property_values << v unless v == ""
					end
					property_names.each_with_index do |name, index|
						property = Spree::Property.new(name: name, presentation: name)
						if property.save
							Spree::ProductProperty.create(product: @product, property: property, value: property_values[index])
						end
					end
					params_specifications = params[:product][:specifications].present? ? params[:product][:specifications].select { |specification| specification != "" } : []
					specifications = []
					params_specifications.each do |specification|
						specifications << Spree::Specification.new(spec: specification)
					end
					@product.specifications = specifications
					params_features = params[:product][:features].present? ? params[:product][:features].select { |feature| feature != "" } : []
					features = []
					params_features.each do |feature|
						features << Spree::ProductFeature.new(description_line: feature)
					end
					@product.product_features = features
					@product.guide = Spree::ImageGuide.new(attachment: params[:product][:guide]) if params[:product][:guide].present?
					params_images = params[:product][:master_images].present? ? params[:product][:master_images].select { |image| image != "" } : []
					images = []
					params_images.each do |image|
						images << Spree::Image.new(attachment: image)
					end
					@product.master.images = images
					@product.save
					redirect_to supplier_store_product_variants_path(@store, @product)
				else
					@products = @store.products
					@product.sku = @product.sku.split('-', 2)[1]
					render 'new'
				end
      end

      def edit
				@product = Spree::Product.friendly.find(params[:id])
				@categories_1_options =
				@specifications = @product.specifications.present? ? @product.specifications.pluck(:spec) : []
				@features = @product.product_features.present? ? @product.product_features.pluck(:description_line) : []
      end

			def update
				option_type_new = []
				option_new_names = params[:product][:option_new_name]
				option_new_names.each do |k, v|
					option_type = Spree::OptionType.new(name: v, presentation: v, store: @store)
					if option_type.save
						option_type_new << option_type
						option_values = params[:product][:option_new_values][k.to_s].split(',')
						option_values.each_with_index do |option_value, index|
							Spree::OptionValue.create(option_type: option_type, name: option_value.strip, presentation: option_value.strip) unless option_value.strip == ""
						end
					end
				end
				@product = Spree::Product.friendly.find(params[:id])
				if @product.update(store_product_params)
					@product.meta_description = @product.description
					@product.taxons = []
					params[:product][:taxon_ids_3].each do |k, taxon_id_3|
						taxon = nil
						if taxon_id_3.present?
							taxon = Spree::Taxon.find(taxon_id_3)
						elsif params[:product][:taxon_ids_2][k.to_s].present?
							taxon = Spree::Taxon.find(params[:product][:taxon_ids_2][k.to_s])
						elsif params[:product][:taxon_ids_1][k.to_s].present?
							taxon = Spree::Taxon.find(params[:product][:taxon_ids_1][k.to_s])
						end
						@product.taxons << taxon unless taxon.nil? || @product.taxons.exists?(taxon)
					end
					@product.option_types = Spree::OptionType.find(params[:product][:option_type_ids].select { |id| id != "" })
					option_type_new.each do |option_type|
						@product.option_types << option_type
					end
					@product.save
					@product.product_properties.destroy_all
					property_names = []
					params[:product][:property_names].each do |k, v|
						property_names << v unless v == ""
					end
					property_values = []
					params[:product][:property_values].each do |k, v|
						property_values << v unless v == ""
					end
					property_names.each_with_index do |name, index|
						property = Spree::Property.new(name: name, presentation: name)
						if property.save
							Spree::ProductProperty.create(product: @product, property: property, value: property_values[index])
						end
					end
					params_specifications = params[:product][:specifications].present? ? params[:product][:specifications].select { |specification| specification != "" } : []
					specifications = []
					params_specifications.each do |specification|
						specifications << Spree::Specification.new(spec: specification)
					end
					@product.specifications = specifications
					params_features = params[:product][:features].present? ? params[:product][:features].select { |feature| feature != "" } : []
					features = []
					params_features.each do |feature|
						features << Spree::ProductFeature.new(description_line: feature)
					end
					@product.product_features = features
					params_images_delete = params[:product][:master_images_delete].present? ? params[:product][:master_images_delete].select { |image| image != "" } : []
					params_images_delete.each do |image|
						Spree::Image.find(image).destroy
					end
					@product.guide = Spree::ImageGuide.new(attachment: params[:product][:guide]) if params[:product][:guide].present?
					params_images = params[:product][:master_images].present? ? params[:product][:master_images].select { |image| image != "" } : []
					params_images.each do |image|
						@product.master.images << Spree::Image.new(attachment: image)
					end
					redirect_to supplier_store_products_path(@store)
				else
					@products = @store.products
					render 'edit'
				end
			end

			def destroy
				@product = Spree::Product.friendly.find(params[:id])
				if @product.destroy
					redirect_to supplier_store_products_path(@store)
				else
					@products = @store.products
					render 'index'
				end
			end

      private

			def this_seller
				@store = Spree::Store.friendly.find(params[:store_id])
				correct_seller @store.seller.user
			end

      def store_product_params
        local_params = params.require(:product).permit(:sku, :price, :name, :description, :available_on, :meta_description, :meta_keywords, :tax_category_id, :shipping_category_id, :properties_label, :guide_label)
				local_params[:available_on] = DateTime.strptime(local_params[:available_on], "%m/%d/%Y") if local_params[:available_on].present?
				local_params[:shipping_category_id] = Spree::ShippingCategory.first.id unless local_params[:shipping_category_id].present?
				local_params
      end
    end
	end
end

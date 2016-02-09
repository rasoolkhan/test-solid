module Spree
	module Supplier
    class VariantsController < Spree::StoreController
			before_action :this_seller
			before_action :store_approved

      def index
				@product = Spree::Product.friendly.find(params[:product_id])
        @variant = Spree::Variant.new
				@variants = @product.variants
      end

      def create
				@product = Spree::Product.friendly.find(params[:product_id])
				@variant = Spree::Variant.new(store_variant_params)
				@variant.product = @product
				@variant.sku = "#{@store.slug}-#{@variant.sku}"
				if @variant.save
					@stock_item = @variant.stock_items.first
          @stock_item.stock_location = Spree::StockLocation.where(store: @store).first
					@stock_location = @stock_item.stock_location
          @stock_item.save!
					adjustment = count_on_hand_adjustment
	        params[:variant].delete(:stock)
	        adjustment -= @stock_item.count_on_hand
	        Spree::StockItem.transaction do
	          adjust_stock_item_count_on_hand(adjustment)
	        end
					params_options = params[:variant][:option_type].present? ? params[:variant][:option_type].select { |k, v| (k != "") && (v != "") } : []
					options = []
					params_options.each do |k, v|
						options << Spree::OptionValue.where(id: v).first
					end
					@variant.option_values = options
					params_images = params[:variant][:images].present? ? params[:variant][:images].select { |k, v| v != "" } : []
					images = []
					params_images.each do |k, v|
						images << Spree::Image.new(attachment: v)
					end
					@variant.images = images
					if @variant.product.option_types.count > 0
						redirect_to supplier_store_product_variants_path(@store, @product)
					else
						redirect_to supplier_store_products_path(@store)
					end
				else
					@variants = @product.variants
					@variant.sku = @variant.sku.split('-', 2)[1]
					render 'index'
				end
      end

      def edit
				@product = Spree::Product.friendly.find(params[:product_id])
        @variant = Spree::Variant.find(params[:id])
				@variant.sku = @variant.sku.split('-', 2)[1]
				@variants = @product.variants
      end

			def update
				@product = Spree::Product.friendly.find(params[:product_id])
				@variant = Spree::Variant.find(params[:id])
				if @variant.update(store_variant_params)
					@variant.sku = "#{@store.slug}-#{@variant.sku}"
					@variant.save
					@stock_item = @variant.stock_items.first
					@stock_location = @stock_item.stock_location
					adjustment = count_on_hand_adjustment
	        params[:variant].delete(:stock)
	        adjustment -= @stock_item.count_on_hand
	        Spree::StockItem.transaction do
	          adjust_stock_item_count_on_hand(adjustment)
	        end
					params_options = params[:variant][:option_type].present? ? params[:variant][:option_type].select { |k, v| (k != "") && (v != "") } : []
					options = []
					params_options.each do |k, v|
						options << Spree::OptionValue.where(id: v).first
					end
					@variant.option_values = options
					params_images = params[:variant][:images].present? ? params[:variant][:images].select { |k, v| (k != "") && (v != "") } : []
					params_images.each do |k, v|
						if Spree::Image.exists?(id: k) && @variant.images.where(id: k).present?
							Spree::Image.find(k).update(attachment: v)
						else
							@variant.images << Spree::Image.new(attachment: v)
						end
					end
					params_images_delete = params[:variant][:images_delete].present? ? params[:variant][:images_delete].select { |image| image != "" } : []
					params_images_delete.each do |image|
						Spree::Image.find(image).destroy
					end
					if @variant.product.option_types.count > 0
						redirect_to supplier_store_product_variants_path(@store, @product)
					else
						redirect_to supplier_store_products_path(@store)
					end
				else
					@variants = @product.variants
					@variant.sku = @variant.sku.split('-', 2)[1]
					render 'edit'
				end
			end

			def destroy
				@product = Spree::Product.friendly.find(params[:product_id])
				@variant = Spree::Variant.find(params[:id])
				if @variant.destroy
					redirect_to supplier_store_product_variants_path(@store, @product)
				else
					@variants = @product.variants
					render 'index'
				end
			end

      private

			def this_seller
				@store = Spree::Store.friendly.find(params[:store_id])
				correct_seller @store.seller.user
			end

      def store_variant_params
        params.require(:variant).permit(:sku, :price, :processing_days, :colour)
      end

			def count_on_hand_adjustment
        params[:variant][:stock].to_i
      end

      def adjust_stock_item_count_on_hand(count_on_hand_adjustment)
        if @stock_item.count_on_hand + count_on_hand_adjustment < 0
          raise StockLocation::InvalidMovementError.new(Spree.t(:stock_not_below_zero))
        end
        @stock_movement = @stock_location.move(@stock_item.variant, count_on_hand_adjustment, spree_current_user)
        @stock_item = @stock_movement.stock_item
      end
    end
	end
end

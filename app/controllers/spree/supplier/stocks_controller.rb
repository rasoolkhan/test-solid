module Spree
	module Supplier
    class StocksController < Spree::StoreController
			before_action :this_seller
			before_action :store_approved

      def index
        @variants = Spree::Variant.where(product: @store.products, is_master: false)
      end

			def edit
        @variant = Spree::Variant.find(params[:id])
        @stock = @variant.stock_items.first
        @variants = Spree::Variant.where(product: @store.products, is_master: false)
			end

			def update
        @variant = Spree::Variant.find(params[:id])
        @stock_item = @variant.stock_items.first
        @stock_location = @stock_item.stock_location
        adjustment = count_on_hand_adjustment
        params[:stock_item].delete(:count_on_hand)
        adjustment -= @stock_item.count_on_hand
        Spree::StockItem.transaction do
          adjust_stock_item_count_on_hand(adjustment)
        end
        redirect_to supplier_store_stock_items_path(@store)
			end

      private

			def this_seller
				@store = Spree::Store.friendly.find(params[:store_id])
				correct_seller @store.seller.user
			end

			def store_stock_items_params
				params.require(:stock_item).permit(:count_on_hand)
			end

      def count_on_hand_adjustment
        params[:stock_item][:count_on_hand].to_i
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

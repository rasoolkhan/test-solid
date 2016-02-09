module Spree
	module Supplier
    class OrdersController < Spree::StoreController
			before_action :this_seller
			before_action :store_approved

      def pending
				@orders = @store.orders.includes(:shipments).where(state: "complete", spree_shipments: {state: "ready"})
      end

      def fulfilled
				@orders = @store.orders.includes(:shipments).where(state: "complete", spree_shipments: {state: "shipped"})
      end

			def show
				@order = Spree::Order.find_by_number(params[:id])
			end

			def ship
				order = Spree::Order.find_by_number(params[:order_id])
				shipments = order.shipments.where(stock_location: @store.stock_location)
				shipments.each do |shipment|
					if shipment.ready?
	          shipment.ship!
	        end
				end
				redirect_to supplier_store_order_path(@store, order)
			end

      private

        def this_seller
  				@store = Spree::Store.friendly.find(params[:store_id])
  				correct_seller @store.seller.user
  			end
    end
  end
end

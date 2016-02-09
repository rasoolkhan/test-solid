module Spree
  module Supplier
    class StoreOrdersController < Spree::OrdersController
      load_and_authorize_resource :class => Spree::StoreOrder
      def show
        @store = Spree::Store.find(params[:store_id])
        @store_order = @store.store_orders.find(params[:id])
        @order = @store_order.order
      end

      def index

        @store = Spree::Store.find(params[:store_id])
        @store_orders = @store.store_orders


        params[:q] ||= {}
        params[:q][:completed_at_not_null] ||= '1' if Spree::Config[:show_only_complete_orders_by_default]
        @show_only_completed = params[:q][:completed_at_not_null] == '1'
        params[:q][:s] ||= @show_only_completed ? 'completed_at desc' : 'created_at desc'
        params[:q][:completed_at_not_null] = '' unless @show_only_completed

        # As date params are deleted if @show_only_completed, store
        # the original date so we can restore them into the params
        # after the search
        created_at_gt = params[:q][:created_at_gt]
        created_at_lt = params[:q][:created_at_lt]

        params[:q].delete(:inventory_units_shipment_id_null) if params[:q][:inventory_units_shipment_id_null] == "0"

        if params[:q][:created_at_gt].present?
          params[:q][:created_at_gt] = Time.zone.parse(params[:q][:created_at_gt]).beginning_of_day rescue ""
        end

        if params[:q][:created_at_lt].present?
          params[:q][:created_at_lt] = Time.zone.parse(params[:q][:created_at_lt]).end_of_day rescue ""
        end

        if @show_only_completed
          params[:q][:completed_at_gt] = params[:q].delete(:created_at_gt)
          params[:q][:completed_at_lt] = params[:q].delete(:created_at_lt)
        end

        @search = Order.accessible_by(current_ability, :index).ransack(params[:q])

        # lazyoading other models here (via includes) may result in an invalid query
        # e.g. SELECT  DISTINCT DISTINCT "spree_orders".id, "spree_orders"."created_at" AS alias_0 FROM "spree_orders"
        # see https://github.com/spree/spree/pull/3919
        @orders = @search.result(distinct: true).
          page(params[:page]).
          per(params[:per_page] || Spree::Config[:orders_per_page])

        

        # Restore dates
        params[:q][:created_at_gt] = created_at_gt
        params[:q][:created_at_lt] = created_at_lt
      end

      def edit
        #can_not_transition_without_customer_info
        @store_order = StoreOrder.find(params[:id])
        @order = @store_order.order
        @store_shipments = @store_order.store_shipments
        # unless @order.completed?
        #   @order.refresh_shipment_rates(ShippingMethod::DISPLAY_ON_FRONT_AND_BACK_END)
        # end
      end

      def model_name
        Spree::StoreOrder
      end

      def update_shipment
        @store_order = Spree::StoreOrder.find(params[:id])
        @order = @store_order.order
        order_shipment = @order.shipments.first
        @ship_items = Spree::LineItem.where(id: params[:ship_items])
        @store_order_shipment = @store_order.store_shipments.last


        @store_order_shipment.inventory_units = @ship_items.map(&:inventory_units).flatten


         
        @order.payment_state = "paid"
        @order.save!

        @store_order_shipment.inventory_units.map(&:fill_backorder)
        @store_order_shipment.tracking = params[:tracking]

        shipping_rate = params[:selected_shipping_rate_id]
        store_shipment_method = @store_order_shipment.shipment.shipping_rates.find(shipping_rate)
        @store_order_shipment.shipper = "#{store_shipment_method.name}"

        #@store_order_shipment.shipping_method = shipment_method
        @store_order_shipment.ready
        if @store_order_shipment.ship
          @new_shipment = @store_order.store_shipments.new(shipment_id: order_shipment.id )
          @new_shipment.save!
        end

        # if @store_order_shipment.save! && @store_order_shipment.ship
        #   @new_shipment = @store_order.store_shipments.new(shipment_id: order_shipment.id )
        #   @new_shipment.save!
        # end

        redirect_to(:back)
        
      end

      def shipment_invoice
        @store_order = Spree::StoreOrder.find(params[:id])
        @store_order_shipment = @store_order.store_shipments.first
        respond_to do |format|
          format.html
          format.pdf do 
            pdf = PDF::Writer.new
            pdf.text @store_order_shipment.inventory_units.map(&:detail)
            send_data pdf.render, :file_name => 'invoice.pdf' ,:type => 'application/pdf',:disposition => 'inline'
          end
        end
      end
    end
  end
end
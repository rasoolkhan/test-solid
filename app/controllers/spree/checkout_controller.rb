module Spree
  # This is somewhat contrary to standard REST convention since there is not
  # actually a Checkout object. There's enough distinct logic specific to
  # checkout which has nothing to do with updating an order that this approach
  # is waranted.
  class CheckoutController < Spree::StoreController
    skip_before_action :verify_authenticity_token, only: :payu
    before_filter :load_order
    around_filter :lock_order
    before_filter :set_state_if_present

    before_action :ensure_order_not_completed
    before_action :ensure_checkout_allowed
    before_action :ensure_sufficient_stock_lines
    before_action :ensure_valid_state

    before_action :associate_user
    before_action :check_authorization
    before_action :apply_coupon_code

    before_action :setup_for_current_state

    helper 'spree/orders'

    rescue_from Spree::Core::GatewayError, :with => :rescue_from_spree_gateway_error

    def edit
      if @order.state == 'confirm'
        @submitHash = Spree::Gateway::PayuIn.submitHash @order
      end
    end

    def update
      if @order.state == 'confirm'
        render :edit
      else
        massaged_params = move_payment_source_into_payments_attributes(params)
        if @order.update_from_params(massaged_params, permitted_checkout_attributes, request.headers.env)
          @order.temporary_address = !params[:save_user_address]
          @order.next
          flash[:error] = @order.errors.full_messages.join("\n")
          redirect_to checkout_state_path(@order.state)
        else
          render :edit
        end
      end
    end

    def payu
      if @order.state == 'confirm'
        Spree::Gateway::PayuIn.responseHash @order, params
        @order.complete
        if @order.completed?
          @current_order = nil
          redirect_to completion_route
        else
          redirect_to checkout_state_path(@order.state)
        end
      else
        render :edit
      end
    end

    private

      def ensure_valid_state
        unless skip_state_validation?
          if (params[:state] && !@order.has_checkout_step?(params[:state])) ||
             (!params[:state] && !@order.has_checkout_step?(@order.state))
            @order.state = 'cart'
            redirect_to checkout_state_path(@order.checkout_steps.first)
          end
        end

        # Fix for #4117
        # If confirmation of payment fails, redirect back to payment screen
        if params[:state] == "confirm" && @order.payment_required? && @order.payments.valid.empty?
          flash.keep
          redirect_to checkout_state_path("payment")
        end
      end

      # Should be overriden if you have areas of your checkout that don't match
      # up to a step within checkout_steps, such as a registration step
      def skip_state_validation?
        false
      end

      def load_order
        @order = current_order
        if @order.state == "confirm" && ['address', 'delivery', 'payment', 'confirm'].exclude?(params[:state])
          params.delete :state
        end
        redirect_to spree.cart_path and return unless @order
      end

      def set_state_if_present
        if params[:state]
          redirect_to checkout_state_path(@order.state) if @order.can_go_to_state?(params[:state]) && !skip_state_validation?
          @order.state = params[:state]
        end
      end

      def ensure_checkout_allowed
        unless @order.checkout_allowed?
          redirect_to spree.cart_path
        end
      end

      def ensure_order_not_completed
        redirect_to spree.cart_path if @order.completed?
      end

      def ensure_sufficient_stock_lines
        if @order.insufficient_stock_lines.present?
          flash[:error] = Spree.t(:inventory_error_flash_for_insufficient_quantity)
          redirect_to spree.cart_path
        end
      end

      # Provides a route to redirect after order completion
      def completion_route
        spree.order_path(@order)
      end

      def setup_for_current_state
        method_name = :"before_#{@order.state}"
        send(method_name) if respond_to?(method_name, true)
      end

      def before_address
        # if the user has a default address, a callback takes care of setting
        # that; but if he doesn't, we need to build an empty one here
        default = {country_id: Country.default.id}
        @order.build_bill_address(default) unless @order.bill_address
        @order.build_ship_address(default) if @order.checkout_steps.include?('delivery') && !@order.ship_address
      end

      def before_delivery
        return if params[:order].present?

        packages = @order.shipments.map { |s| s.to_package }
        @differentiator = Spree::Stock::Differentiator.new(@order, packages)
      end

      def before_payment
        if @order.checkout_steps.include? "delivery"
          packages = @order.shipments.map { |s| s.to_package }
          @differentiator = Spree::Stock::Differentiator.new(@order, packages)
          @differentiator.missing.each do |variant, quantity|
            @order.contents.remove(variant, quantity)
          end
        end

        if try_spree_current_user && try_spree_current_user.respond_to?(:payment_sources)
          @payment_sources = try_spree_current_user.payment_sources
        end
      end

      def rescue_from_spree_gateway_error(exception)
        flash.now[:error] = Spree.t(:spree_gateway_error_flash_for_checkout)
        @order.errors.add(:base, exception.message)
        render :edit
      end

      def check_authorization
        authorize!(:edit, current_order, cookies.signed[:guest_token])
      end
  end
end

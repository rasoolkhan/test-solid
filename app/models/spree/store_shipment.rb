module Spree
	class StoreShipment < ActiveRecord::Base
		belongs_to :store_order
		belongs_to :shipment
    belongs_to :shipping_method, :class_name => 'Spree::ShippingMethod'
		has_many :inventory_units, inverse_of: :store_shipment
		has_many :shipping_rates, -> { order('cost ASC') }, dependent: :delete_all
    has_many :shipping_methods, through: :shipping_rates
    has_many :state_changes, as: :stateful

    after_create :add_initial_inventory_units

    state_machine initial: :pending,use_transactions: false do 
      event :ready do
        transition from: :pending, to: :ready, if: lambda{|store_shipment| 
          store_shipment.determine_state(store_shipment.store_order) == 'ready'
        }
      end 

      event :pend do
        transition from: :ready,to: :pending
      end

      event :ship do
        transition from: [:ready,:canceled], to: :shipped
      end
      after_transition to: :shipped, do: :after_ship

      event :cancel do
        transition from: [:pending, :ready], to: :canceled
      end
    end

    def determine_state(store_order)
      return 'canceled' if store_order.order.canceled?
      return 'pending' unless store_order.order.can_ship?
      return 'pending' if inventory_units.any? &:backordered?
      return 'shipped' if state == 'shipped'
      store_order.order.paid? || Spree::Config[:auto_capture_on_dispatch] ? 'ready' : 'pending'
    end

    def line_items
      inventory_units.includes(:line_item).map(&:line_item).uniq
    end

    def after_ship
      inventory_units.map(&:ship)
    end

    def add_initial_inventory_units
      self.inventory_units = self.store_order.inventory_units.flatten.select{|i| !i.shipped?}
      self.reload
    end

    def unshipped_line_items
       unshipped_line_items = []
       line_items.each {|l| unshipped_line_items << l unless l.inventory_units.any?(&:shipped?)}
       unshipped_line_items
    end
	end
end
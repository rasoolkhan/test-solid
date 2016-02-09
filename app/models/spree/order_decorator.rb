module Spree
	Order.class_eval do
		belongs_to :seller
		has_many :store_orders, dependent: :destroy, class_name: 'Spree::StoreOrder'
		has_many :stores, through: :store_orders

		Spree::Order.state_machine.after_transition to: :confirm, do: :validate_line_item_availability, unless: :unreturned_exchange?
		Spree::Order.state_machine.after_transition to: :confirm, do: :ensure_available_shipping_rates
		Spree::Order.state_machine.after_transition to: :confirm, do: :ensure_promotions_eligible
		Spree::Order.state_machine.after_transition to: :confirm, do: :ensure_line_item_variants_are_not_deleted
		Spree::Order.state_machine.after_transition to: :confirm, do: :ensure_inventory_units, unless: :unreturned_exchange?
	end
end

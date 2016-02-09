module Spree
	class StoreOrder < ActiveRecord::Base
		belongs_to :store
		belongs_to :order
		validates_uniqueness_of :store_id, scope: :order_id





		has_many :line_items
		has_many :variants, through: :line_items

	    def display_total
	      total = line_items.map(&:price).sum
	      total_cost = Spree::Money.new(total, { currency: line_items.first.currency })
	    end

      def inventory_units
        line_items.map(&:inventory_units)
      end
	end
end

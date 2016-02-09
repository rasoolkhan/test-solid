module Spree
	Address.class_eval do
		belongs_to :store, class_name: "Spree::Store"

		validates :phone, presence: true
	end
end
